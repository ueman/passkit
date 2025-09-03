import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

/// Information about a location.
@JsonSerializable(includeIfNull: false)
class Location implements ReadOnlyLocation {
  Location({
    this.altitude,
    required this.latitude,
    required this.longitude,
    this.relevantText,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);

  /// Optional. Altitude, in meters, of the location.
  @override
  @JsonKey(name: 'altitude')
  double? altitude;

  /// Required. Latitude, in degrees, of the location.
  @override
  @JsonKey(name: 'latitude')
  double latitude;

  /// Required. Longitude, in degrees, of the location.
  @override
  @JsonKey(name: 'longitude')
  double longitude;

  /// Optional. Text displayed on the lock screen when the pass is currently
  /// relevant. For example, a description of the nearby location such as
  /// “Store nearby on 1st and Main.”
  @override
  @JsonKey(name: 'relevantText')
  String? relevantText;

  Location copyWith({
    double? altitude,
    double? latitude,
    double? longitude,
    String? relevantText,
  }) {
    return Location(
      altitude: altitude ?? this.altitude,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      relevantText: relevantText ?? this.relevantText,
    );
  }
}

abstract class ReadOnlyLocation {
  /// Optional. Altitude, in meters, of the location.
  double? get altitude;

  /// Required. Latitude, in degrees, of the location.
  double get latitude;

  /// Required. Longitude, in degrees, of the location.
  double get longitude;

  /// Optional. Text displayed on the lock screen when the pass is currently
  /// relevant. For example, a description of the nearby location such as
  /// “Store nearby on 1st and Main.”
  String? get relevantText;
}
