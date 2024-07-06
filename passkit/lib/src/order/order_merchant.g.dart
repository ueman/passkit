// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_merchant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderMerchant _$OrderMerchantFromJson(Map<String, dynamic> json) =>
    OrderMerchant(
      address: json['address'] == null
          ? null
          : OrderAddress.fromJson(json['address'] as Map<String, dynamic>),
      businessChatURL: json['businessChatURL'] == null
          ? null
          : Uri.parse(json['businessChatURL'] as String),
      contactURL: json['contactURL'] == null
          ? null
          : Uri.parse(json['contactURL'] as String),
      displayName: json['displayName'] as String,
      emailAddress: json['emailAddress'] as String?,
      logo: json['logo'] as String?,
      merchantIdentifier: json['merchantIdentifier'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      url: Uri.parse(json['url'] as String),
    );

Map<String, dynamic> _$OrderMerchantToJson(OrderMerchant instance) =>
    <String, dynamic>{
      'address': instance.address,
      'businessChatURL': instance.businessChatURL?.toString(),
      'contactURL': instance.contactURL?.toString(),
      'displayName': instance.displayName,
      'emailAddress': instance.emailAddress,
      'logo': instance.logo,
      'merchantIdentifier': instance.merchantIdentifier,
      'phoneNumber': instance.phoneNumber,
      'url': instance.url.toString(),
    };
