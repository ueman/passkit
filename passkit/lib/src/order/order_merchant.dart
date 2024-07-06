import 'package:json_annotation/json_annotation.dart';
import 'package:passkit/src/order/order_address.dart';

part 'order_merchant.g.dart';

/// The merchant associated with the order.
@JsonSerializable()
class OrderMerchant {
  OrderMerchant({
    required this.address,
    required this.businessChatURL,
    required this.contactURL,
    required this.displayName,
    required this.emailAddress,
    required this.logo,
    required this.merchantIdentifier,
    required this.phoneNumber,
    required this.url,
  });

  /// Creates an instance of this class from a JSON object
  factory OrderMerchant.fromJson(Map<String, dynamic> json) =>
      _$OrderMerchantFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() => _$OrderMerchantToJson(this);

  /// The contact address of the merchant.
  @JsonKey(name: 'address')
  final OrderAddress? address;

  /// An Apple Messages for Business URL the customer uses to contact the
  /// merchant. For more information, see Starting a Message from a URL.
  @JsonKey(name: 'businessChatURL')
  final Uri? businessChatURL;

  /// The URL where the customer can contact the merchant.
  @JsonKey(name: 'contactURL')
  final Uri? contactURL;

  /// The localized display name of the merchant.
  @JsonKey(name: 'displayName')
  final String displayName;

  /// The email address where the customer can contact the merchant.
  @JsonKey(name: 'emailAddress')
  final String? emailAddress;

  /// The name for an image representing the merchant’s logo.
  @JsonKey(name: 'logo')
  final String? logo;

  /// The Apple Merchant Identifier for this merchant,
  /// generated atdeveloper.apple.com.
  @JsonKey(name: 'merchantIdentifier')
  final String merchantIdentifier;

  /// The telephone number where the customer can contact the merchant.
  @JsonKey(name: 'phoneNumber')
  final String? phoneNumber;

  /// The URL for the merchant’s website or landing page.
  @JsonKey(name: 'url')
  final Uri url;
}
