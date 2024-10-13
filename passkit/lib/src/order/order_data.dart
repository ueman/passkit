import 'package:json_annotation/json_annotation.dart';
import 'package:passkit/src/order/order_application.dart';
import 'package:passkit/src/order/order_barcode.dart';
import 'package:passkit/src/order/order_customer.dart';
import 'package:passkit/src/order/order_line_item.dart';
import 'package:passkit/src/order/order_merchant.dart';
import 'package:passkit/src/order/order_payment.dart';
import 'package:passkit/src/order/order_pickup_fulfillment.dart';
import 'package:passkit/src/order/order_provider.dart';
import 'package:passkit/src/order/order_return.dart';
import 'package:passkit/src/order/order_return_info.dart';
import 'package:passkit/src/order/order_shipping_fulfillment.dart';

part 'order_data.g.dart';

@JsonSerializable()
class OrderData {
  OrderData({
    required this.createdAt,
    required this.merchant,
    required this.orderIdentifier,
    required this.orderManagementURL,
    required this.orderType,
    required this.orderTypeIdentifier,
    required this.status,
    this.schemaVersion = 1,
    required this.updatedAt,
    required this.associatedApplications,
    required this.associatedApplicationIdentifiers,
    required this.authenticationToken,
    required this.barcode,
    this.changeNotifications = OrderChangeNotification.enabled,
    required this.customer,
    required this.fulfillments,
    required this.lineItems,
    required this.orderNumber,
    required this.orderProvider,
    required this.payment,
    required this.returnInfo,
    required this.returns,
    required this.statusDescription,
    required this.webServiceURL,
  });

  /// Creates an instance of this class from a JSON object
  factory OrderData.fromJson(Map<String, dynamic> json) =>
      _$OrderDataFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() => _$OrderDataToJson(this);

  /// The date and time when the customer created the order, in RFC 3339 format.
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  /// The merchant for this order.
  @JsonKey(name: 'merchant')
  final OrderMerchant merchant;

  /// A unique order identifier scoped to your order type identifier.
  /// In combination with the order type identifier, this uniquely identifies an
  /// order within the system and isn’t displayed to the user.
  @JsonKey(name: 'orderIdentifier')
  final String orderIdentifier;

  /// (Required) A URL where the customer can manage the order.
  @JsonKey(name: 'orderManagementURL')
  final Uri orderManagementURL;

  /// (Required) The type of order this bundle represents. Currently the only supported value is ecommerce.
  /// Value: ecommerce
  @JsonKey(name: 'orderType')
  final String orderType;

  /// (Required) An identifier for the order type associated with the order. The value must correspond with your signing certificate and isn’t displayed to the user.
  @JsonKey(name: 'orderTypeIdentifier')
  final String orderTypeIdentifier;

  /// (Required) A high-level status of the order, used for display purposes. The system considers orders with status completed or cancelled closed.
  /// Possible Values: open, completed, cancelled
  @JsonKey(name: 'status')
  final OrderStatus status;

  /// (Required) The version of the schema used for the order. The current version is 1.
  @JsonKey(name: 'schemaVersion')
  final num schemaVersion;

  /// (Required) The date and time when the order was last updated, in RFC 3339 format. This should equal the createdAt time, if the order hasn’t had any updates. Must be monotonically increasing. Consider using a hybrid logical clock if your web service can’t make that guarantee.
  @JsonKey(name: 'updatedAt')
  final DateTime updatedAt;

  /// A list of associated applications, in order of preference. The device uses the first available application.
  @JsonKey(name: 'associatedApplications')
  final List<OrderApplication>? associatedApplications;

  /// The application identifier associated with the order.
  @JsonKey(name: 'associatedApplicationIdentifiers')
  final List<String>? associatedApplicationIdentifiers;

  /// The authentication token supplied to your web service. Required if you provide a web service.
  /// Minimum Length: 16
  @JsonKey(name: 'authenticationToken')
  final String? authenticationToken;

  /// An identifier containing information about an order.
  @JsonKey(name: 'barcode')
  final OrderBarcode? barcode;

  /// A property that describes whether the device notifies the user about
  /// relevant changes to the order. The default is enabled.
  @JsonKey(name: 'changeNotifications')
  final OrderChangeNotification changeNotifications;

  /// The customer for this order.
  @JsonKey(name: 'customer')
  final OrderCustomer? customer;

  /// A list of fulfillments. The device displays fulfillments in the order
  /// provided.
  /// Possible types: ShippingFulfillment, PickupFulfillment
  @JsonKey(name: 'fulfillments', fromJson: _fulfillmentsFromJson)
  final List<Object>? fulfillments;

  /// The items contained in the order, displayed in the order provided.
  @JsonKey(name: 'lineItems')
  final List<OrderLineItem>? lineItems;

  /// If available, an order number or reference suitable for display to the
  /// user.
  @JsonKey(name: 'orderNumber')
  final String? orderNumber;

  /// Information about the platform providing the order data. Use this field if
  /// the order data isn’t provided by the merchant, but by a third party.
  @JsonKey(name: 'orderProvider')
  final OrderProvider? orderProvider;

  /// The payment for this order.
  @JsonKey(name: 'payment')
  final OrderPayment? payment;

  /// The information related to a partial or full return.
  @JsonKey(name: 'returnInfo')
  final OrderReturnInfo? returnInfo;

  /// A list of returns. The device displays returns in the order provided.
  @JsonKey(name: 'returns')
  final List<OrderReturn>? returns;

  /// A localized message describing the order status.
  @JsonKey(name: 'statusDescription')
  final String? statusDescription;

  /// The URL of your web service. This must begin with `HTTPS://`.
  @JsonKey(name: 'webServiceURL')
  final Uri? webServiceURL;

  OrderData copyWith({
    DateTime? createdAt,
    OrderMerchant? merchant,
    String? orderIdentifier,
    Uri? orderManagementURL,
    String? orderType,
    String? orderTypeIdentifier,
    OrderStatus? status,
    num? schemaVersion,
    DateTime? updatedAt,
    List<OrderApplication>? associatedApplications,
    List<String>? associatedApplicationIdentifiers,
    String? authenticationToken,
    OrderBarcode? barcode,
    OrderChangeNotification? changeNotifications,
    OrderCustomer? customer,
    List<Object>? fulfillments,
    List<OrderLineItem>? lineItems,
    String? orderNumber,
    OrderProvider? orderProvider,
    OrderPayment? payment,
    OrderReturnInfo? returnInfo,
    List<OrderReturn>? returns,
    String? statusDescription,
    Uri? webServiceURL,
  }) {
    return OrderData(
      createdAt: createdAt ?? this.createdAt,
      merchant: merchant ?? this.merchant,
      orderIdentifier: orderIdentifier ?? this.orderIdentifier,
      orderManagementURL: orderManagementURL ?? this.orderManagementURL,
      orderType: orderType ?? this.orderType,
      orderTypeIdentifier: orderTypeIdentifier ?? this.orderTypeIdentifier,
      status: status ?? this.status,
      schemaVersion: schemaVersion ?? this.schemaVersion,
      updatedAt: updatedAt ?? this.updatedAt,
      associatedApplications:
          associatedApplications ?? this.associatedApplications,
      associatedApplicationIdentifiers: associatedApplicationIdentifiers ??
          this.associatedApplicationIdentifiers,
      authenticationToken: authenticationToken ?? this.authenticationToken,
      barcode: barcode ?? this.barcode,
      changeNotifications: changeNotifications ?? this.changeNotifications,
      customer: customer ?? this.customer,
      fulfillments: fulfillments ?? this.fulfillments,
      lineItems: lineItems ?? this.lineItems,
      orderNumber: orderNumber ?? this.orderNumber,
      orderProvider: orderProvider ?? this.orderProvider,
      payment: payment ?? this.payment,
      returnInfo: returnInfo ?? this.returnInfo,
      returns: returns ?? this.returns,
      statusDescription: statusDescription ?? this.statusDescription,
      webServiceURL: webServiceURL ?? this.webServiceURL,
    );
  }
}

List<Object>? _fulfillmentsFromJson(List<dynamic>? fulfillments) {
  if (fulfillments == null) {
    return null;
  }
  return fulfillments.map((dynamic json) {
    return json as Map<String, dynamic>;
  }).map((json) {
    if (json['fulfillmentType'] == 'shipping') {
      return OrderShippingFulfillment.fromJson(json);
    } else if (json['fulfillmentType'] == 'pickup') {
      return OrderPickupFulfillment.fromJson(json);
    }
    // TODO(any): Create proper exception
    throw Exception();
  }).toList();
}

enum OrderChangeNotification {
  @JsonValue('enabled')
  enabled,

  @JsonValue('disabledIfAppInstalled')
  disabledIfAppInstalled
}

enum OrderStatus {
  @JsonValue('open')
  open,

  @JsonValue('completed')
  completed,

  @JsonValue('cancelled')
  cancelled
}
