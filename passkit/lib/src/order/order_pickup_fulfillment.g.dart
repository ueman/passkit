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
      lineItems: (json['lineItems'] as List<dynamic>?)
          ?.map((e) => OrderLineItem.fromJson(e as Map<String, dynamic>))
          .toList(),
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
      pickupWindowDuration: json['pickupWindowDuration'] as String?,
      status: $enumDecode(_$PickupFulfillmentStatusEnumMap, json['status']),
      statusDescription: json['statusDescription'] as String?,
    );

Map<String, dynamic> _$OrderPickupFulfillmentToJson(
    OrderPickupFulfillment instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('address', instance.address);
  writeNotNull('barcode', instance.barcode);
  val['displayName'] = instance.displayName;
  val['fulfillmentIdentifier'] = instance.fulfillmentIdentifier;
  val['fulfillmentType'] = instance.fulfillmentType;
  writeNotNull('lineItems', instance.lineItems);
  writeNotNull('location', instance.location);
  writeNotNull('notes', instance.notes);
  writeNotNull('pickedUpAt', instance.pickedUpAt?.toIso8601String());
  writeNotNull('pickupAt', instance.pickupAt?.toIso8601String());
  writeNotNull('pickupWindowDuration', instance.pickupWindowDuration);
  val['status'] = _$PickupFulfillmentStatusEnumMap[instance.status]!;
  writeNotNull('statusDescription', instance.statusDescription);
  return val;
}

const _$PickupFulfillmentStatusEnumMap = {
  PickupFulfillmentStatus.open: 'open',
  PickupFulfillmentStatus.processing: 'processing',
  PickupFulfillmentStatus.readyForPickup: 'readyForPickup',
  PickupFulfillmentStatus.pickedUp: 'pickedUp',
  PickupFulfillmentStatus.issue: 'issue',
  PickupFulfillmentStatus.cancelled: 'cancelled',
};
