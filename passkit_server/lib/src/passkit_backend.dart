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

  /// URL must end with "v1/passes/{identifier}/{serial}"
  /// Pass delivery
  ///
  /// GET /v1/passes/<typeID>/<serial#>
  /// Header: Authorization: ApplePass <authenticationToken>
  ///
  /// server response:
  /// --> if auth token is correct: 200, with pass data payload
  /// --> if auth token is incorrect: 401
  Future<PkPass?> getUpdatedPass(
    String identifier,
    String serial,
  );

  Future<NotificationRegistrationReponse> setupNotifications(
    String deviceId,
    String passTypeId,
    String serialNumber,
    String pushToken,
  );

  Future<bool> stopNotifications(
    String deviceId,
    String passTypeId,
    String serialNumber,
  );

  /// Should return true if the [serial] and [authToken] match and are valid.
  /// Otherwise it should return false.
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

class DevPassKitBackend extends PassKitBackend {
  @override
  void noSuchMethod(Invocation invocation) {}
}

enum NotificationRegistrationReponse {
  created,
  existing,
}
