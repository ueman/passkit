// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_pickup_fulfillment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderPickupFulfillment _$OrderPickupFulfillmentFromJson(
        Map<String, dynamic> json) =>
    OrderPickupFulfillment(
      address: json['address'] == null
          ? null
          : OrderAddress.fromJson(json['address'] as Map<String, dynamic>),
      barcode: json['barcode'] == null
          ? null
          : OrderBarcode.fromJson(json['barcode'] as Map<String, dynamic>),
      displayName: json['displayName'] as String,
      fulfillmentIdentifier: json['fulfillmentIdentifier'] as String,
      fulfillmentType: json['fulfillmentType'] as String,
      lineItems: json['lineItems'] == null
          ? null
          : OrderLineItem.fromJson(json['lineItems'] as Map<String, dynamic>),
      location: json['location'] == null
          ? null
          : OrderLocation.fromJson(json['location'] as Map<String, dynamic>),
      notes: json['notes'] as String?,
      pickedUpAt: json['pickedUpAt'] == null
          ? null
          : DateTime.parse(json['pickedUpAt'] as String),
      pickupAt: json['pickupAt'] == null
          ? null
          : DateTime.parse(json['pickupAt'] as String),
      pickupWindowDuration: json['pickupWindowDuration'] == null
          ? null
          : Duration(
              microseconds: (json['pickupWindowDuration'] as num).toInt()),
      status: $enumDecode(_$PickupFulfillmentStatusEnumMap, json['status']),
      statusDescription: json['statusDescription'] as String?,
    );

Map<String, dynamic> _$OrderPickupFulfillmentToJson(
        OrderPickupFulfillment instance) =>
    <String, dynamic>{
      'address': instance.address,
      'barcode': instance.barcode,
      'displayName': instance.displayName,
      'fulfillmentIdentifier': instance.fulfillmentIdentifier,
      'fulfillmentType': instance.fulfillmentType,
      'lineItems': instance.lineItems,
      'location': instance.location,
      'notes': instance.notes,
      'pickedUpAt': instance.pickedUpAt?.toIso8601String(),
      'pickupAt': instance.pickupAt?.toIso8601String(),
      'pickupWindowDuration': instance.pickupWindowDuration?.inMicroseconds,
      'status': _$PickupFulfillmentStatusEnumMap[instance.status]!,
      'statusDescription': instance.statusDescription,
    };

const _$PickupFulfillmentStatusEnumMap = {
  PickupFulfillmentStatus.open: 'open',
  PickupFulfillmentStatus.processing: 'processing',
  PickupFulfillmentStatus.readyForPickup: 'readyForPickup',
  PickupFulfillmentStatus.pickedUp: 'pickedUp',
  PickupFulfillmentStatus.issue: 'issue',
  PickupFulfillmentStatus.cancelled: 'cancelled',
};
