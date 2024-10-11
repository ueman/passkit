import 'package:json_annotation/json_annotation.dart';

part 'beacon.g.dart';

/// Information about a location beacon.
/// Available in iOS 7.0.
@JsonSerializable(includeIfNull: false)
class Beacon {
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
  @JsonKey(name: 'major')
  final int? major;

  /// Optional. Minor identifier of a Bluetooth Low Energy location beacon.
  // 16-bit unsigned integer
  @JsonKey(name: 'minor')
  final int? minor;

  /// Required. Unique identifier of a Bluetooth Low Energy location beacon.
  @JsonKey(name: 'proximityUUID')
  final String proximityUUID;

  /// Optional. Text displayed on the lock screen when the pass is currently
  /// relevant. For example, a description of the nearby location such as
  /// “Store nearby on 1st and Main.”
  @JsonKey(name: 'relevantText')
  final String? relevantText;

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
