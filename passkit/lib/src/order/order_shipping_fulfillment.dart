import 'package:json_annotation/json_annotation.dart';
import 'package:passkit/src/order/order_address.dart';
import 'package:passkit/src/order/order_line_item.dart';

part 'order_shipping_fulfillment.g.dart';

// The details of a shipped order.
@JsonSerializable(includeIfNull: false)
class OrderShippingFulfillment {
  OrderShippingFulfillment({
    required this.fulfillmentIdentifier,
    required this.fulfillmentType,
    required this.status,
    required this.carrier,
    required this.deliveredAt,
    required this.estimatedDeliveryAt,
    required this.estimatedDeliveryWindowDuration,
    required this.lineItems,
    required this.notes,
    required this.recipient,
    required this.shippedAt,
    this.shippingType = OrderShippingFulfillmentType.shipping,
    required this.statusDescription,
    required this.trackingNumber,
    required this.trackingURL,
  });

  /// Creates an instance of this class from a JSON object
  factory OrderShippingFulfillment.fromJson(Map<String, dynamic> json) =>
      _$OrderShippingFulfillmentFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() => _$OrderShippingFulfillmentToJson(this);

  /// (Required) An opaque value that uniquely identifies this fulfillment in
  /// the order. This isn’t displayed to the user, and is only used for
  /// determining changes and user notifications.
  @JsonKey(name: 'fulfillmentIdentifier')
  final String fulfillmentIdentifier;

  /// (Required) The type of fulfillment, which is shipping.
  /// Value: shipping
  @JsonKey(name: 'fulfillmentType')
  final String fulfillmentType;

  /// (Required) The status of the fulfillment.
  /// Possible Values: open, processing, onTheWay, outForDelivery, delivered,
  /// shipped, issue, cancelled
  @JsonKey(name: 'status')
  final OrderShippingFulfillmentStatus status;

  /// The shipping carrier used to complete this fulfillment.
  @JsonKey(name: 'carrier')
  final String? carrier;

  /// The date and time when the carrier delivered the shipment, in RFC 3339 format.
  @JsonKey(name: 'deliveredAt')
  final DateTime? deliveredAt;

  /// The estimated delivery date and time from the carrier, in RFC 3339 format.
  /// The system ignores the time components unless the carrier provides a
  /// window duration.
  @JsonKey(name: 'estimatedDeliveryAt')
  final DateTime? estimatedDeliveryAt;

  /// The duration for the estimated delivery window, in ISO 8601-1 duration format.
  @JsonKey(name: 'estimatedDeliveryWindowDuration')
  final Duration? estimatedDeliveryWindowDuration;

  /// The items the carrier will ship, displayed in the order provided.
  @JsonKey(name: 'lineItems')
  final List<OrderLineItem>? lineItems;

  /// Additional localized information about the shipment. For example, whether
  /// it requires a signature.
  @JsonKey(name: 'notes')
  final String? notes;

  /// The recipient of the shipment.
  @JsonKey(name: 'recipient')
  final ShippingFulfillmentRecipient? recipient;

  /// The date and time when the carrier shipped the order, in RFC 3339 format.
  @JsonKey(name: 'shippedAt')
  final DateTime? shippedAt;

  /// The type used for display.
  /// Default: shipping
  ///
  /// Possible Values: shipping, delivery
  @JsonKey(
    name: 'shippingType',
    defaultValue: OrderShippingFulfillmentType.shipping,
  )
  final OrderShippingFulfillmentType shippingType;

  /// A localized message describing the fulfillment status.
  @JsonKey(name: 'statusDescription')
  final String? statusDescription;

  /// The tracking number provide by the shipping carrier.
  @JsonKey(name: 'trackingNumber')
  final String? trackingNumber;

  /// A URL where the customer can track the shipment.
  @JsonKey(name: 'trackingURL')
  final Uri? trackingURL;

  OrderShippingFulfillment copyWith({
    String? fulfillmentIdentifier,
    String? fulfillmentType,
    OrderShippingFulfillmentStatus? status,
    String? carrier,
    DateTime? deliveredAt,
    DateTime? estimatedDeliveryAt,
    Duration? estimatedDeliveryWindowDuration,
    List<OrderLineItem>? lineItems,
    String? notes,
    ShippingFulfillmentRecipient? recipient,
    DateTime? shippedAt,
    OrderShippingFulfillmentType? shippingType,
    String? statusDescription,
    String? trackingNumber,
    Uri? trackingURL,
  }) {
    return OrderShippingFulfillment(
      fulfillmentIdentifier:
          fulfillmentIdentifier ?? this.fulfillmentIdentifier,
      fulfillmentType: fulfillmentType ?? this.fulfillmentType,
      status: status ?? this.status,
      carrier: carrier ?? this.carrier,
      deliveredAt: deliveredAt ?? this.deliveredAt,
      estimatedDeliveryAt: estimatedDeliveryAt ?? this.estimatedDeliveryAt,
      estimatedDeliveryWindowDuration: estimatedDeliveryWindowDuration ??
          this.estimatedDeliveryWindowDuration,
      lineItems: lineItems ?? this.lineItems,
      notes: notes ?? this.notes,
      recipient: recipient ?? this.recipient,
      shippedAt: shippedAt ?? this.shippedAt,
      shippingType: shippingType ?? this.shippingType,
      statusDescription: statusDescription ?? this.statusDescription,
      trackingNumber: trackingNumber ?? this.trackingNumber,
      trackingURL: trackingURL ?? this.trackingURL,
    );
  }
}

enum OrderShippingFulfillmentType {
  @JsonValue('shipping')
  shipping,

  @JsonValue('delivery')
  delivery
}

enum OrderShippingFulfillmentStatus {
  @JsonValue('open')
  open,

  @JsonValue('processing')
  processing,

  @JsonValue('onTheWay')
  onTheWay,

  @JsonValue('outForDelivery')
  outForDelivery,

  @JsonValue('delivered')
  delivered,

  @JsonValue('shipped')
  shipped,

  @JsonValue('issue')
  issue,

  @JsonValue('cancelled')
  cancelled;

  double toProgress() {
    return switch (this) {
      OrderShippingFulfillmentStatus.open => 0,
      OrderShippingFulfillmentStatus.processing => 0.25,
      OrderShippingFulfillmentStatus.shipped => 0.375,
      OrderShippingFulfillmentStatus.onTheWay => 0.5,
      OrderShippingFulfillmentStatus.outForDelivery => 0.75,
      OrderShippingFulfillmentStatus.delivered => 1,
      OrderShippingFulfillmentStatus.issue => 0,
      OrderShippingFulfillmentStatus.cancelled => 0,
    };
  }
}

@JsonSerializable()
class ShippingFulfillmentRecipient {
  /// Creates an instance of this class from a JSON object
  factory ShippingFulfillmentRecipient.fromJson(Map<String, dynamic> json) =>
      _$ShippingFulfillmentRecipientFromJson(json);

  ShippingFulfillmentRecipient({
    this.address,
    this.familyName,
    this.givenName,
    this.organizationName,
  });

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() => _$ShippingFulfillmentRecipientToJson(this);

  /// The recipient’s address.
  @JsonKey(name: 'address')
  final OrderAddress? address;

  /// The recipient’s family name.
  @JsonKey(name: 'familyName')
  final String? familyName;

  /// The recipient’s given name.
  @JsonKey(name: 'givenName')
  final String? givenName;

  /// The recipient’s organization name.
  @JsonKey(name: 'organizationName')
  final String? organizationName;
}
