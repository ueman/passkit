import 'package:json_annotation/json_annotation.dart';

part 'order_location.g.dart';

/// The details of a pickup order.
@JsonSerializable(includeIfNull: false)
class OrderLocation {
  OrderLocation({
    this.altitude,
    required this.latitude,
    required this.longitude,
  });

  /// Creates an instance of this class from a JSON object
  factory OrderLocation.fromJson(Map<String, dynamic> json) =>
      _$OrderLocationFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() => _$OrderLocationToJson(this);

  /// The altitude above mean sea level, measured in meters.
  final num? altitude;

  /// (Required) The latitude of the location.
  /// Minimum Value: -90
  /// Maximum Value: 90
  final num latitude;

  /// (Required) The longitude of the location.
  /// Minimum Value: -180
  /// Maximum Value: 180
  final num longitude;

  OrderLocation copyWith({
    num? altitude,
    num? latitude,
    num? longitude,
  }) {
    return OrderLocation(
      altitude: altitude ?? this.altitude,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
