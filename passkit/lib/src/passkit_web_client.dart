import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit/src/models/models.dart';
import 'package:passkit/src/passkit_web_client_exceptions.dart';

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
  // TODO(ueman): This could return a PkPass object instead
  Future<Uint8List?> getLatestVersion(
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
    final endpoint = Uri.parse(webServiceUrl).resolveUri(
      Uri(pathSegments: ['v1', 'passes', identifier, serial]),
    );

    final response = await _client.get(
      endpoint,
      headers: {
        if (modifiedSince != null)
          'If-Modified-Since': formatHttpDate(modifiedSince),
        'Authorization': 'ApplePass $authenticationToken',
      },
    );

    return switch (response.statusCode) {
      200 => response.bodyBytes,
      304 => null,
      401 => throw PassKitWebServiceAuthenticationError(),
      _ => throw PassKitWebServiceUnrecognizedStatusCode(response.statusCode),
    };
  }

  /// Record a message on the server.
  ///
  /// Docs:
  /// [https://developer.apple.com/documentation/walletpasses/log_a_message]
  Future<void> logMessages({
    String? webServiceUrl,
    required List<String> messages,
  }) async {
    if (webServiceUrl == null) {
      throw PassKitWebServiceUnsupported();
    }

    final endpoint = Uri.parse(webServiceUrl).resolveUri(
      Uri(pathSegments: ['v1', 'log']),
    );

    await _client.post(endpoint, body: jsonEncode(messages));
  }
}
