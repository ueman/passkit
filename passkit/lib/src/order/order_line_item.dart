import 'package:json_annotation/json_annotation.dart';

part 'order_line_item.g.dart';

@JsonSerializable(includeIfNull: false)
class OrderLineItem {
  OrderLineItem({
    required this.image,
    required this.price,
    required this.quantity,
    required this.subtitle,
    required this.title,
    required this.gtin,
    required this.sku,
  });

  /// Creates an instance of this class from a JSON object
  factory OrderLineItem.fromJson(Map<String, dynamic> json) =>
      _$OrderLineItemFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() => _$OrderLineItemToJson(this);

  /// The name for an image representing the item.
  @JsonKey(name: 'image')
  final String? image;

  /// The price of the line item.
  @JsonKey(name: 'price')
  final OrderCurrencyAmount? price;

  /// (Required) The number of items ordered.
  @JsonKey(name: 'quantity')
  final num quantity;

  /// A localized secondary display title for the item.
  @JsonKey(name: 'subtitle')
  final String? subtitle;

  /// (Required) A localized title for the item.
  @JsonKey(name: 'title')
  final String title;

  /// The Global Trade Item Number of the item, if available. This could be an
  /// EAN, ISBN, or other value.
  @JsonKey(name: 'gtin')
  final String? gtin;

  /// A merchant-specific unique product identifier.
  @JsonKey(name: 'sku')
  final String? sku;

  OrderLineItem copyWith({
    String? image,
    OrderCurrencyAmount? price,
    num? quantity,
    String? subtitle,
    String? title,
    String? gtin,
    String? sku,
  }) {
    return OrderLineItem(
      image: image ?? this.image,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      subtitle: subtitle ?? this.subtitle,
      title: title ?? this.title,
      gtin: gtin ?? this.gtin,
      sku: sku ?? this.sku,
    );
  }
}

@JsonSerializable(includeIfNull: false)
class OrderCurrencyAmount {
  OrderCurrencyAmount({required this.amount, required this.currency});

  /// Creates an instance of this class from a JSON object
  factory OrderCurrencyAmount.fromJson(Map<String, dynamic> json) =>
      _$OrderCurrencyAmountFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() => _$OrderCurrencyAmountToJson(this);

  /// (Required) The monetary amount associated with the currency.
  @JsonKey(name: 'amount')
  final double amount;

  /// (Required) The ISO 4217 currency code that applies to the monetary amount.
  /// Minimum Length: 3
  /// Maximum Length: 3
  @JsonKey(name: 'currency')
  final String currency;

  OrderCurrencyAmount copyWith({
    double? amount,
    String? currency,
  }) {
    return OrderCurrencyAmount(
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
    );
  }
}
