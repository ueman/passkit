// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_shipping_fulfillment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderShippingFulfillment _$OrderShippingFulfillmentFromJson(
        Map<String, dynamic> json) =>
    OrderShippingFulfillment(
      fulfillmentIdentifier: json['fulfillmentIdentifier'] as String,
      fulfillmentType: json['fulfillmentType'] as String,
      status:
          $enumDecode(_$OrderShippingFulfillmentStatusEnumMap, json['status']),
      carrier: json['carrier'] as String?,
      deliveredAt: json['deliveredAt'] == null
          ? null
          : DateTime.parse(json['deliveredAt'] as String),
      estimatedDeliveryAt: json['estimatedDeliveryAt'] == null
          ? null
          : DateTime.parse(json['estimatedDeliveryAt'] as String),
      estimatedDeliveryWindowDuration:
          json['estimatedDeliveryWindowDuration'] == null
              ? null
              : Duration(
                  microseconds:
                      (json['estimatedDeliveryWindowDuration'] as num).toInt()),
      lineItems: (json['lineItems'] as List<dynamic>?)
          ?.map((e) => OrderLineItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      notes: json['notes'] as String?,
      recipient: json['recipient'] == null
          ? null
          : ShippingFulfillmentRecipient.fromJson(
              json['recipient'] as Map<String, dynamic>),
      shippedAt: json['shippedAt'] == null
          ? null
          : DateTime.parse(json['shippedAt'] as String),
      shippingType: $enumDecodeNullable(
              _$OrderShippingFulfillmentTypeEnumMap, json['shippingType']) ??
          OrderShippingFulfillmentType.shipping,
      statusDescription: json['statusDescription'] as String?,
      trackingNumber: json['trackingNumber'] as String?,
      trackingURL: json['trackingURL'] == null
          ? null
          : Uri.parse(json['trackingURL'] as String),
    );

Map<String, dynamic> _$OrderShippingFulfillmentToJson(
        OrderShippingFulfillment instance) =>
    <String, dynamic>{
      'fulfillmentIdentifier': instance.fulfillmentIdentifier,
      'fulfillmentType': instance.fulfillmentType,
      'status': _$OrderShippingFulfillmentStatusEnumMap[instance.status]!,
      'carrier': instance.carrier,
      'deliveredAt': instance.deliveredAt?.toIso8601String(),
      'estimatedDeliveryAt': instance.estimatedDeliveryAt?.toIso8601String(),
      'estimatedDeliveryWindowDuration':
          instance.estimatedDeliveryWindowDuration?.inMicroseconds,
      'lineItems': instance.lineItems,
      'notes': instance.notes,
      'recipient': instance.recipient,
      'shippedAt': instance.shippedAt?.toIso8601String(),
      'shippingType':
          _$OrderShippingFulfillmentTypeEnumMap[instance.shippingType]!,
      'statusDescription': instance.statusDescription,
      'trackingNumber': instance.trackingNumber,
      'trackingURL': instance.trackingURL?.toString(),
    };

const _$OrderShippingFulfillmentStatusEnumMap = {
  OrderShippingFulfillmentStatus.open: 'open',
  OrderShippingFulfillmentStatus.processing: 'processing',
  OrderShippingFulfillmentStatus.onTheWay: 'onTheWay',
  OrderShippingFulfillmentStatus.outForDelivery: 'outForDelivery',
  OrderShippingFulfillmentStatus.delivered: 'delivered',
  OrderShippingFulfillmentStatus.shipped: 'shipped',
  OrderShippingFulfillmentStatus.issue: 'issue',
  OrderShippingFulfillmentStatus.cancelled: 'cancelled',
};

const _$OrderShippingFulfillmentTypeEnumMap = {
  OrderShippingFulfillmentType.shipping: 'shipping',
  OrderShippingFulfillmentType.delivery: 'delivery',
};

ShippingFulfillmentRecipient _$ShippingFulfillmentRecipientFromJson(
        Map<String, dynamic> json) =>
    ShippingFulfillmentRecipient(
      address: json['address'] == null
          ? null
          : OrderAddress.fromJson(json['address'] as Map<String, dynamic>),
      familyName: json['familyName'] as String?,
      givenName: json['givenName'] as String?,
      organizationName: json['organizationName'] as String?,
    );

Map<String, dynamic> _$ShippingFulfillmentRecipientToJson(
        ShippingFulfillmentRecipient instance) =>
    <String, dynamic>{
      'address': instance.address,
      'familyName': instance.familyName,
      'givenName': instance.givenName,
      'organizationName': instance.organizationName,
    };
