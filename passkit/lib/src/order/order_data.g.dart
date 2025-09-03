// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderData _$OrderDataFromJson(Map<String, dynamic> json) => OrderData(
  createdAt: DateTime.parse(json['createdAt'] as String),
  merchant: OrderMerchant.fromJson(json['merchant'] as Map<String, dynamic>),
  orderIdentifier: json['orderIdentifier'] as String,
  orderManagementURL: Uri.parse(json['orderManagementURL'] as String),
  orderType: json['orderType'] as String,
  orderTypeIdentifier: json['orderTypeIdentifier'] as String,
  status: $enumDecode(_$OrderStatusEnumMap, json['status']),
  schemaVersion: json['schemaVersion'] as num? ?? 1,
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  associatedApplications: (json['associatedApplications'] as List<dynamic>?)
      ?.map((e) => OrderApplication.fromJson(e as Map<String, dynamic>))
      .toList(),
  associatedApplicationIdentifiers:
      (json['associatedApplicationIdentifiers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
  authenticationToken: json['authenticationToken'] as String?,
  barcode: json['barcode'] == null
      ? null
      : OrderBarcode.fromJson(json['barcode'] as Map<String, dynamic>),
  changeNotifications:
      $enumDecodeNullable(
        _$OrderChangeNotificationEnumMap,
        json['changeNotifications'],
      ) ??
      OrderChangeNotification.enabled,
  customer: json['customer'] == null
      ? null
      : OrderCustomer.fromJson(json['customer'] as Map<String, dynamic>),
  fulfillments: _fulfillmentsFromJson(json['fulfillments'] as List?),
  lineItems: (json['lineItems'] as List<dynamic>?)
      ?.map((e) => OrderLineItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  orderNumber: json['orderNumber'] as String?,
  orderProvider: json['orderProvider'] == null
      ? null
      : OrderProvider.fromJson(json['orderProvider'] as Map<String, dynamic>),
  payment: json['payment'] == null
      ? null
      : OrderPayment.fromJson(json['payment'] as Map<String, dynamic>),
  returnInfo: json['returnInfo'] == null
      ? null
      : OrderReturnInfo.fromJson(json['returnInfo'] as Map<String, dynamic>),
  returns: (json['returns'] as List<dynamic>?)
      ?.map((e) => OrderReturn.fromJson(e as Map<String, dynamic>))
      .toList(),
  statusDescription: json['statusDescription'] as String?,
  webServiceURL: json['webServiceURL'] == null
      ? null
      : Uri.parse(json['webServiceURL'] as String),
);

Map<String, dynamic> _$OrderDataToJson(OrderData instance) => <String, dynamic>{
  'createdAt': instance.createdAt.toIso8601String(),
  'merchant': instance.merchant,
  'orderIdentifier': instance.orderIdentifier,
  'orderManagementURL': instance.orderManagementURL.toString(),
  'orderType': instance.orderType,
  'orderTypeIdentifier': instance.orderTypeIdentifier,
  'status': _$OrderStatusEnumMap[instance.status]!,
  'schemaVersion': instance.schemaVersion,
  'updatedAt': instance.updatedAt.toIso8601String(),
  'associatedApplications': instance.associatedApplications,
  'associatedApplicationIdentifiers': instance.associatedApplicationIdentifiers,
  'authenticationToken': instance.authenticationToken,
  'barcode': instance.barcode,
  'changeNotifications':
      _$OrderChangeNotificationEnumMap[instance.changeNotifications]!,
  'customer': instance.customer,
  'fulfillments': instance.fulfillments,
  'lineItems': instance.lineItems,
  'orderNumber': instance.orderNumber,
  'orderProvider': instance.orderProvider,
  'payment': instance.payment,
  'returnInfo': instance.returnInfo,
  'returns': instance.returns,
  'statusDescription': instance.statusDescription,
  'webServiceURL': instance.webServiceURL?.toString(),
};

const _$OrderStatusEnumMap = {
  OrderStatus.open: 'open',
  OrderStatus.completed: 'completed',
  OrderStatus.cancelled: 'cancelled',
};

const _$OrderChangeNotificationEnumMap = {
  OrderChangeNotification.enabled: 'enabled',
  OrderChangeNotification.disabledIfAppInstalled: 'disabledIfAppInstalled',
};
