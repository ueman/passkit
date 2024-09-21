import 'dart:async';

import 'package:passkit/passkit.dart';

abstract class PassKitBackend {
  /// Saves JSON that gets send to `/v1/log`
  Future<void> logMessage(Map<String, dynamic> message);

  /// Return `null` if there are no updatable passes.
  /// Otherwise return an instance of it.
  /// [lastTag], if non-null, describes the last point in time where the wallet
  /// app made a request to get updateable passes.
  Future<UpdatablePassResponse?> returnUpdatablePasses(
    String deviceId,
    String typeId,
    String? lastTag,
  );

  /// Must return the latest pass for the given [identifier] and [serial]
  Future<PkPass?> getLatestPassFor(
    String identifier,
    String serial,
  );

  /// Start sending push notifications for the given parameters.
  /// Consider that a user can have added the same pass to multiple devices.
  Future<NotificationRegistrationReponse> startSendingPushNotificationsFor(
    String deviceId,
    String passTypeId,
    String serialNumber,
    String pushToken,
  );

  /// Stop sending push notifications for the given parameters.
  /// Consider that a user can have added the same pass to multiple devices.
  Future<bool> stopSendingPushNotificationsFor(
    String deviceId,
    String passTypeId,
    String serialNumber,
  );

  /// Should return true if the [serial] and [authToken] match each other
  /// and are valid on their own. Otherwise it should return false.
  FutureOr<bool> isValidAuthToken(String serial, String authToken);

  /// Should return true if the [deviceId] is known, otherwise it should return
  /// false.
  FutureOr<bool> isKnownDeviceId(String deviceId);
}

class UpdatablePassResponse {
  UpdatablePassResponse({this.tag, required this.ids}) : assert(ids.isNotEmpty);

  final String? tag;
  final List<String> ids;

  Map<String, dynamic> toJson() {
    return {
      'lastUpdated': tag,
      'serialNumbers': ids,
    };
  }
}

enum NotificationRegistrationReponse {
  created,
  existing,
}
