// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_return.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderReturn _$OrderReturnFromJson(Map<String, dynamic> json) => OrderReturn(
      returnIdentifier: json['returnIdentifier'] as String,
      status: json['status'] as String,
      carrier: json['carrier'] as String?,
      dropOffBy: json['dropOffBy'] == null
          ? null
          : DateTime.parse(json['dropOffBy'] as String),
      initiatedAt: json['initiatedAt'] == null
          ? null
          : DateTime.parse(json['initiatedAt'] as String),
      lineItems: (json['lineItems'] as List<dynamic>?)
          ?.map((e) => OrderLineItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      notes: json['notes'] as String?,
      returnedAt: json['returnedAt'] == null
          ? null
          : DateTime.parse(json['returnedAt'] as String),
      returnLabel: json['returnLabel'] as String?,
      returnManagementURL: json['returnManagementURL'] == null
          ? null
          : Uri.parse(json['returnManagementURL'] as String),
      returnNumber: json['returnNumber'] as String?,
      statusDescription: json['statusDescription'] as String?,
    );

Map<String, dynamic> _$OrderReturnToJson(OrderReturn instance) {
  final val = <String, dynamic>{
    'returnIdentifier': instance.returnIdentifier,
    'status': instance.status,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('carrier', instance.carrier);
  writeNotNull('dropOffBy', instance.dropOffBy?.toIso8601String());
  writeNotNull('initiatedAt', instance.initiatedAt?.toIso8601String());
  writeNotNull('lineItems', instance.lineItems);
  writeNotNull('notes', instance.notes);
  writeNotNull('returnedAt', instance.returnedAt?.toIso8601String());
  writeNotNull('returnLabel', instance.returnLabel);
  writeNotNull('returnManagementURL', instance.returnManagementURL?.toString());
  writeNotNull('returnNumber', instance.returnNumber);
  writeNotNull('statusDescription', instance.statusDescription);
  return val;
}
