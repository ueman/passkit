# PassKit Server

[![pub package](https://img.shields.io/pub/v/passkit_server.svg)](https://pub.dev/packages/passkit_server)
[![likes](https://img.shields.io/pub/likes/passkit_server)](https://pub.dev/packages/passkit_server/score)
[![popularity](https://img.shields.io/pub/popularity/passkit_server)](https://pub.dev/packages/passkit_server/score)
[![pub points](https://img.shields.io/pub/points/passkit_server)](https://pub.dev/packages/passkit_server/score)


[![Twitter Follow](https://img.shields.io/twitter/follow/ue_man?style=social)](https://twitter.com/ue_man)
[![GitHub followers](https://img.shields.io/github/followers/ueman?style=social)](https://github.com/ueman)

-------

PassKit allows you to work with Apple's PkPass and Order files. This is a Dart library, which allows you to integrate the PassKit enpoint in your shelf (and potentially dart_frog) application.

In order to show PassKit and Order files in Flutter, use the [`passkit_ui`](https://pub.dev/packages/passkit_ui) package, which includes ready made widgets.

Want to work with Apple's native PassKit APIs in Flutter? Consider using [`apple_passkit`](https://pub.dev/packages/apple_passkit).

Please read through the [Apple Documentation](https://developer.apple.com/documentation/walletpasses/adding-a-web-service-to-update-passes) for the server implementation first.

A brief example looks roughly like this. Unfortunately, it's not possible to move more logic into
the library, since it depends too much on your application logic.

```dart
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
```

# How to structure persistence for the server

Apple recommend to build the persistence this way:

Updating passes requires storing information for the registered passes and for their associated devices. One way you can store these details is to use a traditional relational database with two entities – devices and passes – and one relationship, registrations. The three tables are:

#### Device table
Contains the devices that contain updatable passes. Information for a device includes the device library identifier and the push token that your server uses to send update notifications.

#### Pass table
Contains the updatable passes. Information for a pass includes the pass type identifier, serial number, and a last-update tag. You define the contents of this tag and use it to track when you last updated a pass. The table can also include other data that you require to generate an updated pass.

#### Registration table
Contains the relationships between passes and devices. Use this table to find the devices registered for a pass, and to find all the registered passes for a device. Both relationships are many-to-many.
