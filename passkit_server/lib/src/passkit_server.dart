import 'dart:async';
import 'dart:convert';

import 'package:passkit_server/src/passkit_backend.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

extension PasskitServerExtension on Router {
  void addPassKitServer(PassKitBackend backend) {
    get('/v1/passes/<identifier>/<serial>', getLatestVersion);
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
  var header = request.headers['Authorization'];
  var token = header?.split(' ').lastOrNull;

  if (header?.startsWith('ApplePass ') == false || token == null) {
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
  if (request.method == 'POST') {
    final content = await request.readAsString();
    DevPassKitBackend().logMessage(jsonDecode(content) as Map<String, dynamic>);
  }
  return Response.notFound(null);
}

// POST request
/// URL must end with "v1/devices/{deviceLibraryIdentifier}/registrations/{passTypeIdentifier}/{serialNumber}"
FutureOr<Response> setupNotifications(Request request) {
  return Response.notFound(null);
}

// DELETE request
/// URL must end with "v1/devices/{deviceLibraryIdentifier}/registrations/{passTypeIdentifier}/{serialNumber}"
FutureOr<Response> stopNotifications(Request request) {
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
FutureOr<Response> getListOfUpdatablePasses(Request request) {
  return Response.notFound(null);
}

// POST request
/// URL must end with "v1/passes/{passTypeIdentifier}/{serialNumber}/personalize"
FutureOr<Response> personalize(Request request) {
  return Response.notFound(null);
}
