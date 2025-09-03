import 'package:json_annotation/json_annotation.dart';

part 'beacon.g.dart';

/// Information about a location beacon.
/// Available in iOS 7.0.
@JsonSerializable(includeIfNull: false)
class Beacon implements ReadOnlyBeacon {
  Beacon({
    this.major,
    this.minor,
    required this.proximityUUID,
    this.relevantText,
  });

  /// Creates an instance of [Beacon] from a JSON object
  factory Beacon.fromJson(Map<String, dynamic> json) => _$BeaconFromJson(json);

  /// Optional. Major identifier of a Bluetooth Low Energy location beacon.
  // 16-bit unsigned integer
  @override
  @JsonKey(name: 'major')
  int? major;

  /// Optional. Minor identifier of a Bluetooth Low Energy location beacon.
  // 16-bit unsigned integer
  @override
  @JsonKey(name: 'minor')
  int? minor;

  /// Required. Unique identifier of a Bluetooth Low Energy location beacon.
  @override
  @JsonKey(name: 'proximityUUID')
  String proximityUUID;

  /// Optional. Text displayed on the lock screen when the pass is currently
  /// relevant. For example, a description of the nearby location such as
  /// “Store nearby on 1st and Main.”
  @override
  @JsonKey(name: 'relevantText')
  String? relevantText;

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() => _$BeaconToJson(this);

  Beacon copyWith({
    int? major,
    int? minor,
    String? proximityUUID,
    String? relevantText,
  }) {
    return Beacon(
      major: major ?? this.major,
      minor: minor ?? this.minor,
      proximityUUID: proximityUUID ?? this.proximityUUID,
      relevantText: relevantText ?? this.relevantText,
    );
  }
}

abstract class ReadOnlyBeacon {
  /// Optional. Major identifier of a Bluetooth Low Energy location beacon.
  // 16-bit unsigned integer
  int? get major;

  /// Optional. Minor identifier of a Bluetooth Low Energy location beacon.
  // 16-bit unsigned integer
  int? get minor;

  /// Required. Unique identifier of a Bluetooth Low Energy location beacon.
  String get proximityUUID;

  /// Optional. Text displayed on the lock screen when the pass is currently
  /// relevant. For example, a description of the nearby location such as
  /// “Store nearby on 1st and Main.”
  String? get relevantText;
}
