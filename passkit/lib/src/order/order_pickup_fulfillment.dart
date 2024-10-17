import 'package:json_annotation/json_annotation.dart';
import 'package:passkit/src/order/order_address.dart';
import 'package:passkit/src/order/order_barcode.dart';
import 'package:passkit/src/order/order_line_item.dart';
import 'package:passkit/src/order/order_location.dart';

part 'order_pickup_fulfillment.g.dart';

/// The details of a pickup order.
@JsonSerializable(includeIfNull: false)
class OrderPickupFulfillment {
  OrderPickupFulfillment({
    required this.address,
    required this.barcode,
    required this.displayName,
    required this.fulfillmentIdentifier,
    required this.fulfillmentType,
    required this.lineItems,
    required this.location,
    required this.notes,
    required this.pickedUpAt,
    required this.pickupAt,
    required this.pickupWindowDuration,
    required this.status,
    required this.statusDescription,
  });

  /// Creates an instance of this class from a JSON object
  factory OrderPickupFulfillment.fromJson(Map<String, dynamic> json) =>
      _$OrderPickupFulfillmentFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() => _$OrderPickupFulfillmentToJson(this);

  /// The address for the order pickup.
  final OrderAddress? address;

  /// The barcode the customer shows at pickup.
  final OrderBarcode? barcode;

  /// (Required) The localized name of the pickup location.
  final String displayName;

  /// (Required) An opaque value that uniquely identifies this fulfillment in
  /// the order. This isn’t displayed to the user and only for determining
  /// changes and user notifications.
  final String fulfillmentIdentifier;

  /// (Required) The type of fulfillment, which is pickup.
  /// Value: pickup
  final String fulfillmentType;

  /// The items for the customer to pick up, displayed in the order provided.
  final List<OrderLineItem>? lineItems;

  /// The latitude and longitude of the pickup location. Use this when you
  /// require greater precision than address alone (for example, for accurate
  /// indoor mapping display).
  final OrderLocation? location;

  /// Localized instructions for the pickup.
  final String? notes;

  /// The date and time when the customer picked up the order, in RFC 3339 format.
  final DateTime? pickedUpAt;

  /// The date and time when the pickup window starts, in RFC 3339 format.
  final DateTime? pickupAt;

  /// The duration for which the pickup window is open, in ISO 8601-1 duration format.
  final String? pickupWindowDuration;

  /// (Required) The status of the fulfillment.
  /// Possible Values: open, processing, readyForPickup, pickedUp, issue, cancelled
  final PickupFulfillmentStatus status;

  /// A localized message describing the fulfillment status.
  final String? statusDescription;

  OrderPickupFulfillment copyWith({
    OrderAddress? address,
    OrderBarcode? barcode,
    String? displayName,
    String? fulfillmentIdentifier,
    String? fulfillmentType,
    List<OrderLineItem>? lineItems,
    OrderLocation? location,
    String? notes,
    DateTime? pickedUpAt,
    DateTime? pickupAt,
    String? pickupWindowDuration,
    PickupFulfillmentStatus? status,
    String? statusDescription,
  }) {
    return OrderPickupFulfillment(
      address: address ?? this.address,
      barcode: barcode ?? this.barcode,
      displayName: displayName ?? this.displayName,
      fulfillmentIdentifier:
          fulfillmentIdentifier ?? this.fulfillmentIdentifier,
      fulfillmentType: fulfillmentType ?? this.fulfillmentType,
      lineItems: lineItems ?? this.lineItems,
      location: location ?? this.location,
      notes: notes ?? this.notes,
      pickedUpAt: pickedUpAt ?? this.pickedUpAt,
      pickupAt: pickupAt ?? this.pickupAt,
      pickupWindowDuration: pickupWindowDuration ?? this.pickupWindowDuration,
      status: status ?? this.status,
      statusDescription: statusDescription ?? this.statusDescription,
    );
  }
}

enum PickupFulfillmentStatus {
  @JsonValue('open')
  open,

  @JsonValue('processing')
  processing,

  @JsonValue('readyForPickup')
  readyForPickup,

  @JsonValue('pickedUp')
  pickedUp,

  @JsonValue('issue')
  issue,

  @JsonValue('cancelled')
  cancelled
}
