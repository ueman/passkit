import 'package:json_annotation/json_annotation.dart';

part 'order_customer.g.dart';

/// The details of the order’s customer.
@JsonSerializable()
class OrderCustomer {
  OrderCustomer({
    required this.emailAddress,
    required this.familyName,
    required this.givenName,
    required this.organizationName,
    required this.phoneNumber,
  });

  /// Creates an instance of this class from a JSON object
  factory OrderCustomer.fromJson(Map<String, dynamic> json) =>
      _$OrderCustomerFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() => _$OrderCustomerToJson(this);

  /// The customer’s email address.
  @JsonKey(name: 'emailAddress')
  final String emailAddress;

  /// The customer’s family name.
  @JsonKey(name: 'familyName')
  final String familyName;

  /// The customer’s given name.
  @JsonKey(name: 'givenName')
  final String givenName;

  /// The customer’s organization name.
  @JsonKey(name: 'organizationName')
  final String organizationName;

  /// The customer’s phone number.
  @JsonKey(name: 'phoneNumber')
  final String phoneNumber;
}
