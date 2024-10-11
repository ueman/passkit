import 'dart:async';

import 'package:passkit/src/pkpass/pkpass.dart';
import 'package:passkit_server/passkit_server.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

Future<void> main() async {
  var app = Router();

  app.addPassKitServer(CustomPassKitBackend());

  app.get('/hello', (Request request) {
    return Response.ok('hello-world');
  });

  // ignore: unused_local_variable
  var server = await io.serve(app.call, 'localhost', 8888);
}

class CustomPassKitBackend extends PassKitBackend {
  @override
  Future<PkPass?> getLatestPassFor(String identifier, String serial) async {
    print('getLatestPassFor($identifier, $serial)');
    return null;
  }

  @override
  FutureOr<bool> isKnownDeviceId(String deviceId) {
    print('isKnownDeviceId($deviceId)');
    return true;
  }

  @override
  FutureOr<bool> isValidAuthToken(String serial, String authToken) {
    print('isValidAuthToken($serial, $authToken)');
    return true;
  }

  @override
  Future<void> logMessage(Map<String, dynamic> message) async {
    print('logMessage($message)');
  }

  @override
  Future<UpdatablePassResponse?> returnUpdatablePasses(
    String deviceId,
    String typeId,
    String? lastTag,
  ) async {
    print('returnUpdatablePasses($deviceId, $typeId, $lastTag)');
    return null;
  }

  @override
  Future<NotificationRegistrationReponse> startSendingPushNotificationsFor(
    String deviceId,
    String passTypeId,
    String serialNumber,
    String pushToken,
  ) async {
    print(
      'startSendingPushNotificationsFor($deviceId, $passTypeId, $serialNumber, $pushToken)',
    );
    return NotificationRegistrationReponse.created;
  }

  @override
  Future<bool> stopSendingPushNotificationsFor(
    String deviceId,
    String passTypeId,
    String serialNumber,
  ) async {
    print(
      'stopSendingPushNotificationsFor($deviceId, $passTypeId, $serialNumber)',
    );
    return true;
  }
}
