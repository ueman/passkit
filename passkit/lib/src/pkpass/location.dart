import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

/// Information about a location.
@JsonSerializable()
class Location {
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
  @JsonKey(name: 'altitude')
  final double? altitude;

  /// Required. Latitude, in degrees, of the location.
  @JsonKey(name: 'latitude')
  final double latitude;

  /// Required. Longitude, in degrees, of the location.
  @JsonKey(name: 'longitude')
  final double longitude;

  /// Optional. Text displayed on the lock screen when the pass is currently
  /// relevant. For example, a description of the nearby location such as
  /// “Store nearby on 1st and Main.”
  @JsonKey(name: 'relevantText')
  final String? relevantText;
}
