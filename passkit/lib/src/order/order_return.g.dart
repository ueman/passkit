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

Map<String, dynamic> _$OrderReturnToJson(OrderReturn instance) =>
    <String, dynamic>{
      'returnIdentifier': instance.returnIdentifier,
      'status': instance.status,
      'carrier': ?instance.carrier,
      'dropOffBy': ?instance.dropOffBy?.toIso8601String(),
      'initiatedAt': ?instance.initiatedAt?.toIso8601String(),
      'lineItems': ?instance.lineItems,
      'notes': ?instance.notes,
      'returnedAt': ?instance.returnedAt?.toIso8601String(),
      'returnLabel': ?instance.returnLabel,
      'returnManagementURL': ?instance.returnManagementURL?.toString(),
      'returnNumber': ?instance.returnNumber,
      'statusDescription': ?instance.statusDescription,
    };
