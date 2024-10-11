import 'dart:convert';

import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:passkit/src/order/pk_order.dart';
import 'package:passkit/src/order_webservice/order_identifiers.dart';
import 'package:passkit/src/order_webservice/order_web_client_exceptions.dart';
import 'package:passkit/src/utils.dart';

/// This class allows you to update a [Order] the latest version, if the pass
/// allows it.
///
/// Docs:
/// [https://developer.apple.com/documentation/walletpasses/send_an_updated_pass]
class OrderWebClient {
  /// If a [client] is passed to the constructor it will be used, otherwise a
  /// default instance will be created. This is useful for testing, or for using
  /// other implementations like [https://pub.dev/packages/cupertino_http] or
  /// [https://pub.dev/packages/cronet_http].
  OrderWebClient({Client? client}) : _client = client ?? Client();

  final Client _client;

  /// Loads the latest version for the given pass. Throws, if the pass doesn't
  /// support being updated. To check whether a pass supports being updated,
  /// check whether [PkOrder.isWebServiceAvailable] returns true.
  ///
  /// Returns null if no new order is available.
  ///
  /// If [modifiedSince] is present, only updates after [modifiedSince] will be
  /// considered.
  Future<PkOrder?> getLatestVersion(
    PkOrder order, {
    DateTime? modifiedSince,
  }) async {
    if (!order.isWebServiceAvailable) {
      throw OrderWebServiceUnsupported();
    }

    final webServiceUrl = order.order.webServiceURL!;
    final authenticationToken = order.order.authenticationToken!;

    final identifier = order.order.orderTypeIdentifier;
    final serial = order.order.orderIdentifier;
    final endpoint =
        webServiceUrl.appendPathSegments(['v1', 'orders', identifier, serial]);

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
      401 => throw OrderWebServiceAuthenticationError(),
      _ => throw OrderWebServiceUnrecognizedStatusCode(response.statusCode),
    };

    if (bytes != null) {
      return PkOrder.fromBytes(bytes);
    }
    return null;
  }

  /// Record a message on the server.
  ///
  /// Docs:
  /// [https://developer.apple.com/documentation/walletpasses/log_a_message]
  Future<void> logMessages(PkOrder order, List<String> messages) async {
    final webServiceUrl = order.order.webServiceURL;
    if (webServiceUrl == null) {
      throw OrderWebServiceUnsupported();
    }

    final endpoint = webServiceUrl.appendPathSegments(['v1', 'log']);

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
    PkOrder order, {
    required String deviceLibraryIdentifier,
    required String pushToken,
  }) async {
    // https://yourpasshost.example.com/v1/devices/{deviceLibraryIdentifier}/registrations/{passTypeIdentifier}/{serialNumber}

    final webServiceUrl = order.order.webServiceURL;
    if (webServiceUrl == null) {
      throw OrderWebServiceUnsupported();
    }
    final authenticationToken = order.order.authenticationToken!;

    final endpoint = webServiceUrl.appendPathSegments(
      [
        'v1',
        'devices',
        deviceLibraryIdentifier,
        'registrations',
        order.order.orderTypeIdentifier,
        order.order.orderIdentifier,
      ],
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
        throw OrderWebServiceAuthenticationError();
      default:
        throw OrderWebServiceUnrecognizedStatusCode(response.statusCode);
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
    PkOrder order, {
    required String deviceLibraryIdentifier,
  }) async {
    // https://yourpasshost.example.com/v1/devices/{deviceLibraryIdentifier}/registrations/{passTypeIdentifier}/{serialNumber}

    final webServiceUrl = order.order.webServiceURL;
    if (webServiceUrl == null) {
      throw OrderWebServiceUnsupported();
    }
    final authenticationToken = order.order.authenticationToken!;

    final endpoint = webServiceUrl.appendPathSegments(
      [
        'v1',
        'devices',
        deviceLibraryIdentifier,
        'registrations',
        order.order.orderTypeIdentifier,
        order.order.orderIdentifier,
      ],
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
        throw OrderWebServiceAuthenticationError();
      default:
        throw OrderWebServiceUnrecognizedStatusCode(response.statusCode);
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
  Future<OrderIdentifiers?> getListOfUpdatablePasses(
    PkOrder order, {
    required String deviceLibraryIdentifier,
    required String? previousLastUpdated,
  }) async {
    // https://yourpasshost.example.com/v1/devices/{deviceLibraryIdentifier}/registrations/{passTypeIdentifier}?passesUpdatedSince={previousLastUpdated}
    final webServiceUrl = order.order.webServiceURL;
    if (webServiceUrl == null) {
      throw OrderWebServiceUnsupported();
    }

    final endpoint = webServiceUrl.appendPathSegments([
      'v1',
      'devices',
      deviceLibraryIdentifier,
      'registrations',
      order.order.orderTypeIdentifier,
    ]).replace(
      queryParameters: {
        if (previousLastUpdated != null)
          'passesUpdatedSince': previousLastUpdated,
      },
    );

    final response = await _client.get(endpoint);

    return switch (response.statusCode) {
      200 => () {
          final responseJson = utf8JsonDecode(response.bodyBytes)!;
          return OrderIdentifiers.fromJson(responseJson);
        }(),
      204 => null,
      401 => throw OrderWebServiceAuthenticationError(),
      _ => throw OrderWebServiceUnrecognizedStatusCode(response.statusCode),
    };
  }
}

extension on Uri {
  Uri appendPathSegments(List<String> additionalSegments) =>
      replace(pathSegments: [...pathSegments, ...additionalSegments]);
}
