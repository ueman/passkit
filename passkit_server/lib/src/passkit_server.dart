import 'dart:async';
import 'dart:convert';

import 'package:passkit_server/src/passkit_backend.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

extension PasskitServerExtension on Router {
  void addPassKitServer(PassKitBackend backend) {
    get('/v1/passes/<identifier>/<serial>', getLatestVersion);
    get('/v1/devices/<deviceID>/registrations/<typeID>',
        getListOfUpdatablePasses);
    delete(
      '/v1/devices/<deviceID>/registrations/<passTypeID>/<serial>',
      stopNotifications,
    );
    post(
      '/v1/devices/<deviceID>/registrations/<passTypeID>/<serial>',
      setupNotifications,
    );
    post('/v1/log', logMessages);
  }
}

// GET request
/// URL must end with "v1/passes/{identifier}/{serial}"
/// Pass delivery
///
/// GET /v1/passes/<typeID>/<serial#>
/// Header: Authorization: ApplePass <authenticationToken>
///
/// server response:
/// --> if auth token is correct: 200, with pass data payload
/// --> if auth token is incorrect: 401
FutureOr<Response> getLatestVersion(
  Request request,
  String identifier,
  String serial,
) async {
  var token = request.getApplePassToken();

  if (token == null) {
    return Response.unauthorized(null);
  }

  final pass =
      await DevPassKitBackend().getUpdatedPass(identifier, serial, token);

  if (pass == null) {
    return Response.unauthorized(null);
  }

  return Response.ok(pass.sourceData);
}

// POST request
/// URL must end with "v1/log"
FutureOr<Response> logMessages(Request request) async {
  final content = await request.readAsString();
  DevPassKitBackend().logMessage(jsonDecode(content) as Map<String, dynamic>);
  return Response.ok(null);
}

// POST request
/// URL must end with "v1/devices/{deviceLibraryIdentifier}/registrations/{passTypeIdentifier}/{serialNumber}"
FutureOr<Response> setupNotifications(
  Request request,
  String deviceId,
  String passTypeId,
  String serialNumber,
) {
  return Response.notFound(null);
}

/// Unregister
///
/// unregister a device to receive push notifications for a pass
///
/// DELETE /v1/devices/<deviceID>/registrations/<passTypeID>/<serialNumber>
/// Header: Authorization: ApplePass <authenticationToken>
///
/// server action: if the authentication token is correct, disassociate the device from this pass
/// server response:
/// --> if disassociation succeeded: 200
/// --> if not authorized: 401
FutureOr<Response> stopNotifications(
  Request request,
  String deviceId,
  String passTypeId,
  String serialNumber,
) {
  var token = request.getApplePassToken();

  if (token == null) {
    return Response.unauthorized(null);
  }
  return Response.notFound(null);
}

// GET request
/// URL must end with "v1/devices/{deviceLibraryIdentifier}/registrations/{passTypeIdentifier}"
/// Updatable passes
///
/// get all serial numbers associated with a device for passes that need an update
/// Optionally with a query limiter to scope the last update since
///
/// GET /v1/devices/<deviceID>/registrations/<typeID>
/// GET /v1/devices/<deviceID>/registrations/<typeID>?passesUpdatedSince=<tag>
///
/// server action: figure out which passes associated with this device have been modified since the supplied tag (if no tag provided, all associated serial numbers)
/// server response:
/// --> if there are matching passes: 200, with JSON payload: { "lastUpdated" : <new tag>, "serialNumbers" : [ <array of serial numbers> ] }
/// --> if there are no matching passes: 204
/// --> if unknown device identifier: 404
FutureOr<Response> getListOfUpdatablePasses(
  Request request,
  String deviceId,
  String typeId,
) {
  return Response.notFound(null);
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
