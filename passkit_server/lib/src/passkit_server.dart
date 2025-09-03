import 'dart:async';
import 'dart:convert';

import 'package:passkit_server/src/passkit_backend.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

extension PasskitServerExtension on Router {
  void addPassKitServer(PassKitBackend backend) {
    post(
      '/v1/devices/<deviceID>/registrations/<passTypeID>/<serial>',
      setupNotifications(backend),
    );
    get(
      '/v1/devices/<deviceID>/registrations/<typeID>',
      getListOfUpdatablePasses(backend),
    );
    delete(
      '/v1/devices/<deviceID>/registrations/<passTypeID>/<serial>',
      stopNotifications(backend),
    );
    get('/v1/passes/<identifier>/<serial>', getLatestVersion(backend));
    post('/v1/log', logMessages(backend));
  }
}

/// Pass delivery
///
/// `GET /v1/passes/<typeID>/<serial#>`
/// `Header: Authorization: ApplePass <authenticationToken>`
///
/// server response:
/// --> if auth token is correct: 200, with pass data payload
/// --> if auth token is incorrect: 401
Function getLatestVersion(PassKitBackend backend) {
  return (Request request, String identifier, String serial) async {
    final response = await backend.validateAuthToken(request, serial);
    if (response != null) {
      return response;
    }

    final pass = await backend.getLatestPassFor(identifier, serial);

    if (pass == null) {
      return Response.unauthorized(null);
    }

    return Response.ok(
      pass.sourceData,
      headers: {
        'Content-type': 'application/vnd.apple.pkpass',
        'Content-disposition': 'attachment; filename=pass.pkpass',
      },
    );
  };
}

/// Logging/Debugging from the device
///
/// log an error or unexpected server behavior, to help with server debugging
/// POST /v1/log
/// JSON payload: `{ "description" : <human-readable description of error> }`
///
/// server response: 200
Function logMessages(PassKitBackend backend) {
  return (Request request) async {
    final content = await request.readAsString();
    // There's no need to wait for the log message to be written, instead return
    // a 200 status code response right away
    unawaited(
      backend.logMessage(jsonDecode(content) as Map<String, dynamic>),
    );
    return Response.ok(null);
  };
}

/// Registration
/// register a device to receive push notifications for a pass
///
/// `POST /v1/devices/<deviceID>/registrations/<typeID>/<serial#>`
/// `Header: Authorization: ApplePass <authenticationToken>`
/// JSON payload:
/// ```json
/// { "pushToken" : <push token, which the server needs to send push notifications to this device> }
/// ```
///
/// Params definition
/// [deviceId] : the device's identifier
/// [passTypeId] : the bundle identifier for a class of passes, sometimes refered
///               to as the pass topic, e.g. pass.com.apple.backtoschoolgift,
///               registered with WWDR
/// [serialNumber] : the pass' serial number
/// `pushToken` (from the [request]): the value needed for Apple Push Notification service
///
/// server action: if the authentication token is correct, associate the given
///                push token and device identifier with this pass
/// server response:
/// --> if registration succeeded: 201
/// --> if this serial number was already registered for this device: 304
/// --> if not authorized: 401
Function setupNotifications(PassKitBackend backend) {
  return (
    Request request,
    String deviceId,
    String passTypeId,
    String serialNumber,
  ) async {
    final response = await backend.validateAuthToken(request, serialNumber);
    if (response != null) {
      return response;
    }
    final body = await request.readAsString();
    final bodyJson = jsonDecode(body) as Map<String, dynamic>;
    final pushToken = bodyJson['pushToken'] as String?;
    if (pushToken == null) {
      // TODO(anyone): include more information in debug mode?
      return Response.badRequest();
    }

    final notificationRegistrationReponse =
        await backend.startSendingPushNotificationsFor(
      deviceId,
      passTypeId,
      serialNumber,
      pushToken,
    );

    return switch (notificationRegistrationReponse) {
      NotificationRegistrationReponse.created => Response(201),
      NotificationRegistrationReponse.existing => Response.ok(null),
    };
  };
}

/// Unregister
///
/// unregister a device to receive push notifications for a pass
///
/// `DELETE /v1/devices/<deviceID>/registrations/<passTypeID>/<serial#>`
/// `Header: Authorization: ApplePass <authenticationToken>`
///
/// server action: if the authentication token is correct, disassociate the
///                device from this pass
/// server response:
/// --> if disassociation succeeded: 200
/// --> if not authorized: 401
Function stopNotifications(PassKitBackend backend) {
  return (
    Request request,
    String deviceId,
    String passTypeId,
    String serialNumber,
  ) async {
    final response = await backend.validateAuthToken(request, serialNumber);
    if (response != null) {
      return response;
    }
    final success = await backend.stopSendingPushNotificationsFor(
      deviceId,
      passTypeId,
      serialNumber,
    );
    if (success) {
      return Response.ok(null);
    }

    // TODO(anyone): Is this correct?
    return Response.internalServerError();
  };
}

/// Updatable passes
///
/// Get all serial numbers associated with a device for passes that need an update
/// Optionally with a query limiter to scope the last update since
///
/// `GET /v1/devices/<deviceID>/registrations/<typeID>`
/// `GET /v1/devices/<deviceID>/registrations/<typeID>?passesUpdatedSince=<tag>`
///
/// server action: figure out which passes associated with this device have been modified since the supplied tag (if no tag provided, all associated serial #s)
/// server response:
/// --> if there are matching passes: 200, with JSON payload: `{ "lastUpdated" : <new tag>, "serialNumbers" : [ <array of serial #s> ] }`
/// --> if there are no matching passes: 204
/// --> if unknown device identifier: 404
Function getListOfUpdatablePasses(PassKitBackend backend) {
  return (Request request, String deviceId, String typeId) async {
    final isKnownDeviceIdentifier = await backend.isKnownDeviceId(deviceId);
    if (!isKnownDeviceIdentifier) {
      return Response.notFound(null);
    }
    final lastTag = request.url.queryParameters['passesUpdatedSince'];

    final updateablePasses =
        await backend.returnUpdatablePasses(deviceId, typeId, lastTag);

    if (updateablePasses == null) {
      return Response(204);
    }

    return Response.ok(jsonEncode(updateablePasses.toJson()));
  };
}

extension on Request {
  String? getApplePassToken() {
    var header = headers['Authorization'];
    if (header?.startsWith('ApplePass ') == true) {
      var token = header?.split(' ').lastOrNull;
      return token;
    }

    return null;
  }
}

extension on PassKitBackend {
  Future<Response?> validateAuthToken(Request request, String serial) async {
    var token = request.getApplePassToken();

    if (token == null) {
      return Response.unauthorized(null);
    }

    final isValidToken = await isValidAuthToken(serial, token);
    if (!isValidToken) {
      return Response.unauthorized(null);
    }
    return null;
  }
}
