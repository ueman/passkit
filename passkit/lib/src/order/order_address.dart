import 'package:json_annotation/json_annotation.dart';

part 'order_address.g.dart';

/// The physical address for an order.
@JsonSerializable()
class OrderAddress {
  OrderAddress({
    required this.addressLines,
    required this.administrativeArea,
    required this.countryCode,
    required this.locality,
    required this.postalCode,
    required this.subAdministrativeArea,
    required this.subLocality,
  });

  /// Creates an instance of this class from a JSON object
  factory OrderAddress.fromJson(Map<String, dynamic> json) =>
      _$OrderAddressFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() => _$OrderAddressToJson(this);

  /// The street portion of the address.
  @JsonKey(name: 'addressLines')
  final List<String>? addressLines;

  /// The state or administrative area of the address.
  @JsonKey(name: 'administrativeArea')
  final String? administrativeArea;

  /// The country of the address, in ISO-3166 two-letter format.
  /// Minimum Length: 2
  /// Maximum Length: 2
  @JsonKey(name: 'countryCode')
  final String? countryCode;

  /// The city of the address.
  @JsonKey(name: 'locality')
  final String? locality;

  /// The ZIP or postal code, where applicable, of the address.
  @JsonKey(name: 'postalCode')
  final String? postalCode;

  /// The subadministrative area (such as county or other region) of the address.
  @JsonKey(name: 'subAdministrativeArea')
  final String? subAdministrativeArea;

  /// Additional information associated with the location, such as a district or neighborhood.
  @JsonKey(name: 'subLocality')
  final String? subLocality;
}
