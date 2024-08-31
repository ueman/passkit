import 'package:passkit/passkit.dart';

abstract class PassKitBackend {
  /// Saves JSON that gets send to `/v1/log`
  Future<void> logMessage(Map<String, dynamic> message);

  /// "/v1/passes/{identifier}/{serial}""
  Future<UpdatablePassResponse?> returnUpdatablePasses(
    String identifier,
    String serial,
    String updatedSince,
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
    String authenticationToken,
  );
}

class UpdatablePassResponse {
  UpdatablePassResponse._(this.response, {this.tag, this.ids});

  factory UpdatablePassResponse.matchingPasses(String tag, List<String> ids) {
    return UpdatablePassResponse._(200, tag: tag, ids: ids);
  }

  factory UpdatablePassResponse.noMatchingPasses() =>
      UpdatablePassResponse._(204);
  factory UpdatablePassResponse.unknownDeviceIdentifier() =>
      UpdatablePassResponse._(404);

  final String? tag;
  final List<String>? ids;

  final int response;
}

class DevPassKitBackend extends PassKitBackend {
  @override
  void noSuchMethod(Invocation invocation) {}
}
