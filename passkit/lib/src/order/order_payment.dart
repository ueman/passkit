import 'package:json_annotation/json_annotation.dart';
import 'package:passkit/src/order/order_line_item.dart';

part 'order_payment.g.dart';

@JsonSerializable()
class OrderPayment {
  OrderPayment({
    required this.total,
    this.summaryItems,
    this.transactions,
    required this.paymentMethods,
    required this.status,
    required this.applePayTransactionIdentifiers,
  });

  /// (Required) The total amount to be paid.
  @JsonKey(name: 'total')
  final OrderCurrencyAmount total;

  /// A breakdown of the total payment. For example, shipping cost and taxes.
  @JsonKey(name: 'summaryItems')
  final List<PaymentSummaryItems>? summaryItems;

  /// A list of PaymentTransaction dictionaries.
  @JsonKey(name: 'transactions')
  final List<PaymentTransaction>? transactions;

  /// Deprecated  A list of methods used to pay. For example, MasterCard 1234 or
  /// Visa 5678.
  // Apple doesn't list a reason or replacement for the deprecation
  // ignore: provide_deprecation_message
  @deprecated
  @JsonKey(name: 'paymentMethods')
  final List<String>? paymentMethods;

  /// Deprecated  (Required) The status of the payment.
  /// Possible Values: pending, authorized, paid, refunded, declined, voided
  // Apple doesn't list a reason or replacement for the deprecation
  // ignore: provide_deprecation_message
  @deprecated
  @JsonKey(name: 'status')
  final String? status;

  /// Deprecated  An optional list of Apple Pay transaction identifiers relating
  /// to this order. Wallet links the original transaction to your order by
  /// default. If you charge a user multiple times, you can provide the relevant
  /// transaction identifiers here to enable additional linking.
  // Apple doesn't list a reason or replacement for the deprecation
  // ignore: provide_deprecation_message
  @deprecated
  @JsonKey(name: 'applePayTransactionIdentifiers')
  final List<String>? applePayTransactionIdentifiers;
}

/// The details about a payment transaction.
@JsonSerializable()
class PaymentTransaction {
  PaymentTransaction({
    required this.amount,
    required this.createdAt,
    required this.paymentMethod,
    required this.status,
    required this.applePayTransactionIdentifier,
    required this.transactionType,
    required this.receipt,
  });

  /// Creates an instance of this class from a JSON object
  factory PaymentTransaction.fromJson(Map<String, dynamic> json) =>
      _$PaymentTransactionFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() => _$PaymentTransactionToJson(this);

  /// (Required) The amount of the transaction.
  @JsonKey(name: 'amount')
  final OrderCurrencyAmount amount;

  /// (Required) The date and time when the framework created the transaction,
  /// in RFC 3339 format.
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  /// (Required) A string that represents the payment, such as a payment pass or
  /// card used for the transaction.
  @JsonKey(name: 'paymentMethod')
  final OrderPaymentMethod paymentMethod;

  /// (Required) The fulfillment status.
  /// Possible Values: pending, approved, completed, cancelled, failed
  @JsonKey(name: 'status')
  final PaymentTransactionStatus status;

  /// A string that represents the Apple Pay transaction ID.
  @JsonKey(name: 'applePayTransactionIdentifier')
  final String? applePayTransactionIdentifier;

  /// (Required) The type of transaction.
  /// Possible Values: purchase, refund
  @JsonKey(name: 'transactionType')
  final PaymentTransactionType transactionType;

  /// The filename of a receipt within the bundle that’s associated with the transaction.
  @JsonKey(name: 'receipt')
  final String? receipt;
}

enum PaymentTransactionStatus {
  @JsonValue('pending')
  pending,

  @JsonValue('approved')
  approved,

  @JsonValue('completed')
  completed,

  @JsonValue('cancelled')
  cancelled,

  @JsonValue('failed')
  failed
}

enum PaymentTransactionType {
  @JsonValue('purchase')
  purchase,

  @JsonValue('refund')
  refund
}

@JsonSerializable()
class OrderPaymentMethod {
  OrderPaymentMethod({required this.displayName});

  /// Creates an instance of this class from a JSON object
  factory OrderPaymentMethod.fromJson(Map<String, dynamic> json) =>
      _$OrderPaymentMethodFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() => _$OrderPaymentMethodToJson(this);

  /// (Required) The name of the payment method, such as the name of a specific payment pass or card.
  @JsonKey(name: 'displayName')
  final String displayName;
}

/// A breakdown of the total payment.
@JsonSerializable()
class PaymentSummaryItems {
  PaymentSummaryItems({required this.label, required this.value});

  /// Creates an instance of this class from a JSON object
  factory PaymentSummaryItems.fromJson(Map<String, dynamic> json) =>
      _$PaymentSummaryItemsFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() => _$PaymentSummaryItemsToJson(this);

  /// (Required) A localized label.
  @JsonKey(name: 'label')
  final String label;

  /// (Required) The monetary value.
  @JsonKey(name: 'value')
  final OrderCurrencyAmount value;
}
