import 'package:json_annotation/json_annotation.dart';
import 'package:passkit/src/order/order_line_item.dart';

part 'order_return.g.dart';

/// The details of a return order.
@JsonSerializable()
class OrderReturn {
  OrderReturn({
    required this.returnIdentifier,
    required this.status,
    required this.carrier,
    required this.dropOffBy,
    required this.initiatedAt,
    required this.lineItems,
    required this.notes,
    required this.returnedAt,
    required this.returnLabel,
    required this.returnManagementURL,
    required this.returnNumber,
    required this.statusDescription,
  });

  /// Creates an instance of this class from a JSON object
  factory OrderReturn.fromJson(Map<String, dynamic> json) =>
      _$OrderReturnFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() => _$OrderReturnToJson(this);

  /// (Required) A unique identifier for the return. This isn’t displayed to the
  /// user, and is only used for identifying changes and user notifications.
  @JsonKey(name: 'returnIdentifier')
  final String returnIdentifier;

  /// (Required) The status of the return.
  /// Possible Values: open, onTheWay, processing, issue, completed, cancelled
  @JsonKey(name: 'status')
  final String status;

  /// The carrier used to return the products.
  @JsonKey(name: 'carrier')
  final String? carrier;

  /// The date and time for the product drop-off.
  /// Use ISO 8601 format.
  @JsonKey(name: 'dropOffBy')
  final DateTime? dropOffBy;

  /// The date and time for the initated return.
  /// Use ISO 8601 format.
  @JsonKey(name: 'initiatedAt')
  final DateTime? initiatedAt;

  /// An array of line items for the customer to return, displayed in the order
  /// provided.
  @JsonKey(name: 'lineItems')
  final List<OrderLineItem>? lineItems;

  /// Additional information about the return.
  @JsonKey(name: 'notes')
  final String? notes;

  /// The return date and time of a product.
  /// Use ISO 8601 format.
  @JsonKey(name: 'returnedAt')
  final DateTime? returnedAt;

  /// A printable filename of a label within the bundle used to mail the
  /// products back. The total size of the bundle must be below 5 MB.
  ///
  /// Supports, PDF, JPG, and PNG labels.
  @JsonKey(name: 'returnLabel')
  final String? returnLabel;

  /// A URL where the customer can manage the return.
  @JsonKey(name: 'returnManagementURL')
  final Uri? returnManagementURL;

  /// The number of the return displayed to the customer.
  @JsonKey(name: 'returnNumber')
  final String? returnNumber;

  /// A localized message describing the return status.
  @JsonKey(name: 'statusDescription')
  final String? statusDescription;
}
