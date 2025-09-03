// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_line_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderLineItem _$OrderLineItemFromJson(Map<String, dynamic> json) =>
    OrderLineItem(
      image: json['image'] as String?,
      price: json['price'] == null
          ? null
          : OrderCurrencyAmount.fromJson(json['price'] as Map<String, dynamic>),
      quantity: json['quantity'] as num,
      subtitle: json['subtitle'] as String?,
      title: json['title'] as String,
      gtin: json['gtin'] as String?,
      sku: json['sku'] as String?,
    );

Map<String, dynamic> _$OrderLineItemToJson(OrderLineItem instance) =>
    <String, dynamic>{
      'image': ?instance.image,
      'price': ?instance.price,
      'quantity': instance.quantity,
      'subtitle': ?instance.subtitle,
      'title': instance.title,
      'gtin': ?instance.gtin,
      'sku': ?instance.sku,
    };

OrderCurrencyAmount _$OrderCurrencyAmountFromJson(Map<String, dynamic> json) =>
    OrderCurrencyAmount(
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
    );

Map<String, dynamic> _$OrderCurrencyAmountToJson(
  OrderCurrencyAmount instance,
) => <String, dynamic>{
  'amount': instance.amount,
  'currency': instance.currency,
};
