import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:passkit/passkit.dart';

/// Dart uses a special fast decoder when using a fused [Utf8Decoder] and [JsonDecoder].
/// This speeds up decoding.
/// See https://github.com/dart-lang/sdk/blob/5b2ea0c7a227d91c691d2ff8cbbeb5f7f86afdb9/sdk/lib/_internal/vm/lib/convert_patch.dart#L40
final _utf8JsonDecoder = const Utf8Decoder().fuse(const JsonDecoder());

/// This class allows you to update a [PkPass] the latest version, if the pass
/// allows it.
///
/// Docs:
/// [https://developer.apple.com/documentation/walletpasses/send_an_updated_pass]
class PassKitWebClient {
  /// If a [client] is passed to the constructor it will be used, otherwise a
  /// default instance will be created. This is useful for testing, or for using
  /// other implementations like [https://pub.dev/packages/cupertino_http] or
  /// [https://pub.dev/packages/cronet_http].
  PassKitWebClient({Client? client}) : _client = client ?? Client();

  final Client _client;

  /// Loads the latest version for the given pass. Throws, if the pass doesn't
  /// support being updated. To check whether a pass supports being updated,
  /// check whether [PkPass.isWebServiceAvailable] returns true.
  ///
  /// Returns null if no new pass is available.
  ///
  /// If [modifiedSince] is present, only updates after [modifiedSince] will be
  /// considered.
  Future<PkPass?> getLatestVersion(
    PkPass pass, {
    DateTime? modifiedSince,
  }) async {
    if (!pass.isWebServiceAvailable) {
      throw PassKitWebServiceUnsupported();
    }

    final webServiceUrl = pass.pass.webServiceURL!;
    final authenticationToken = pass.pass.authenticationToken!;

    final identifier = pass.pass.passTypeIdentifier;
    final serial = pass.pass.serialNumber;
    final endpoint = Uri.parse(webServiceUrl)
        .resolveUri(Uri(pathSegments: ['v1', 'passes', identifier, serial]));

    final response = await _client.get(
      endpoint,
      headers: {
        if (modifiedSince != null)
          'If-Modified-Since': formatHttpDate(modifiedSince),
        'Authorization': 'ApplePass $authenticationToken',
      },
    );

    final bytes = switch (response.statusCode) {
      200 => response.bodyBytes,
      304 => null,
      401 => throw PassKitWebServiceAuthenticationError(),
      _ => throw PassKitWebServiceUnrecognizedStatusCode(response.statusCode),
    };

    if (bytes != null) {
      return PkPass.fromBytes(bytes);
    }
    return null;
  }

  /// Record a message on the server.
  ///
  /// Docs:
  /// [https://developer.apple.com/documentation/walletpasses/log_a_message]
  Future<void> logMessages(PkPass pass, List<String> messages) async {
    final webServiceUrl = pass.pass.webServiceURL;
    if (webServiceUrl == null) {
      throw PassKitWebServiceUnsupported();
    }

    final endpoint =
        Uri.parse(webServiceUrl).resolveUri(Uri(pathSegments: ['v1', 'log']));

    await _client.post(endpoint, body: jsonEncode(messages));
  }

  /// Set up change notifications for a pass on a device.
  ///
  /// [deviceLibraryIdentifier] : A unique identifier you use to identify and
  /// authenticate the device.
  ///
  /// [pushToken] : A push token the server uses to send update notifications
  /// for a registered pass to a device.
  ///
  /// Docs:
  /// https://developer.apple.com/documentation/walletpasses/register_a_pass_for_update_notifications
  Future<void> setupNotifications(
    PkPass pass, {
    required String deviceLibraryIdentifier,
    required String pushToken,
  }) async {
    // https://yourpasshost.example.com/v1/devices/{deviceLibraryIdentifier}/registrations/{passTypeIdentifier}/{serialNumber}

    final webServiceUrl = pass.pass.webServiceURL;
    if (webServiceUrl == null) {
      throw PassKitWebServiceUnsupported();
    }
    final authenticationToken = pass.pass.authenticationToken!;

    final endpoint = Uri.parse(webServiceUrl).resolveUri(
      Uri(
        pathSegments: [
          'v1',
          'devices',
          deviceLibraryIdentifier,
          'registrations',
          pass.pass.passTypeIdentifier,
          pass.pass.serialNumber,
        ],
      ),
    );

    final response = await _client.post(
      endpoint,
      headers: {
        'Authorization': 'ApplePass $authenticationToken',
      },
      body: jsonEncode({
        'pushToken': pushToken,
      }),
    );

    switch (response.statusCode) {
      case 200:
        // The serial number is already registered for the device.
        // We consider this success too, so no throwing
        null;
      case 201:
        // Success. The registration is successful.
        null;
      case 401:
        throw PassKitWebServiceAuthenticationError();
      default:
        throw PassKitWebServiceUnrecognizedStatusCode(response.statusCode);
    }
  }

  /// Unregister a Pass for Update Notifications
  /// Stop sending update notifications for a pass on a device.
  ///
  /// [deviceLibraryIdentifier] : A unique identifier you use to identify and
  /// authenticate the device.
  ///
  /// Docs:
  /// https://developer.apple.com/documentation/walletpasses/unregister_a_pass_for_update_notifications
  Future<void> stopNotifications(
    PkPass pass, {
    required String deviceLibraryIdentifier,
  }) async {
    // https://yourpasshost.example.com/v1/devices/{deviceLibraryIdentifier}/registrations/{passTypeIdentifier}/{serialNumber}

    final webServiceUrl = pass.pass.webServiceURL;
    if (webServiceUrl == null) {
      throw PassKitWebServiceUnsupported();
    }
    final authenticationToken = pass.pass.authenticationToken!;

    final endpoint = Uri.parse(webServiceUrl).resolveUri(
      Uri(
        pathSegments: [
          'v1',
          'devices',
          deviceLibraryIdentifier,
          'registrations',
          pass.pass.passTypeIdentifier,
          pass.pass.serialNumber,
        ],
      ),
    );

    final response = await _client.delete(
      endpoint,
      headers: {
        'Authorization': 'ApplePass $authenticationToken',
      },
    );

    switch (response.statusCode) {
      case 200:
        // The serial number is already registered for the device.
        // We consider this success too, so no throwing
        null;
      case 401:
        throw PassKitWebServiceAuthenticationError();
      default:
        throw PassKitWebServiceUnrecognizedStatusCode(response.statusCode);
    }
  }

  /// Send the serial numbers for updated passes to a device.
  ///
  /// [deviceLibraryIdentifier] : A unique identifier you use to identify and
  /// authenticate the device.
  ///
  /// [previousLastUpdated] : The value of the lastUpdated key from the
  /// SerialNumbers object returned in a previous request. This value limits the
  /// results of the current request to the passes updated since that previous
  /// request.
  ///
  /// Docs: https://developer.apple.com/documentation/walletpasses/get_the_list_of_updatable_passes
  Future<SerialNumbers?> getListOfUpdatablePasses(
    PkPass pass, {
    required String deviceLibraryIdentifier,
    required String? previousLastUpdated,
  }) async {
    // https://yourpasshost.example.com/v1/devices/{deviceLibraryIdentifier}/registrations/{passTypeIdentifier}?passesUpdatedSince={previousLastUpdated}
    final webServiceUrl = pass.pass.webServiceURL;
    if (webServiceUrl == null) {
      throw PassKitWebServiceUnsupported();
    }

    final endpoint = Uri.parse(webServiceUrl).resolveUri(
      Uri(
        pathSegments: [
          'v1',
          'devices',
          deviceLibraryIdentifier,
          'registrations',
          pass.pass.passTypeIdentifier,
        ],
        queryParameters: {
          if (previousLastUpdated != null)
            'passesUpdatedSince': previousLastUpdated,
        },
      ),
    );

    final response = await _client.get(endpoint);

    return switch (response.statusCode) {
      200 => () {
          final responseJson = _utf8JsonDecoder.convert(response.bodyBytes)
              as Map<String, dynamic>;
          return SerialNumbers(
            serialNumbers: responseJson['serialNumbers'] as List<String>,
            lastUpdated: responseJson['lastUpdated'] as String,
          );
        }(),
      204 => null,
      401 => throw PassKitWebServiceAuthenticationError(),
      _ => throw PassKitWebServiceUnrecognizedStatusCode(response.statusCode),
    };
  }

  /// Return a Personalized Pass
  /// Create and sign a personalized pass, and send it to a device.
  ///
  /// The request is successful and returns a signed personalization token.
  /// It's the [PersonalizationDictionary.personalizationToken] property but
  /// signed.
  ///
  /// Docs:
  /// https://developer.apple.com/documentation/walletpasses/return_a_personalized_pass
  Future<Uint8List?> personalize(
    PkPass pass, {
    required PersonalizationDictionary personalization,
  }) async {
    // POST https://yourpasshost.example.com/v1/passes/{passTypeIdentifier}/{serialNumber}/personalize
    final webServiceUrl = pass.pass.webServiceURL;
    if (webServiceUrl == null) {
      throw PassKitWebServiceUnsupported();
    }

    final endpoint = Uri.parse(webServiceUrl).resolveUri(
      Uri(
        pathSegments: [
          'v1',
          'passes',
          pass.pass.passTypeIdentifier,
          pass.pass.serialNumber,
          'personalize',
        ],
      ),
    );

    final response = await _client.post(
      endpoint,
      body: jsonEncode(personalization),
    );

    switch (response.statusCode) {
      case 200:
        return response.bodyBytes;
      default:
        throw PassKitWebServiceUnrecognizedStatusCode(response.statusCode);
    }
  }
}
