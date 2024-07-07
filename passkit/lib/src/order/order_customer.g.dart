// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderCustomer _$OrderCustomerFromJson(Map<String, dynamic> json) =>
    OrderCustomer(
      emailAddress: json['emailAddress'] as String,
      familyName: json['familyName'] as String,
      givenName: json['givenName'] as String,
      organizationName: json['organizationName'] as String,
      phoneNumber: json['phoneNumber'] as String,
    );

Map<String, dynamic> _$OrderCustomerToJson(OrderCustomer instance) =>
    <String, dynamic>{
      'emailAddress': instance.emailAddress,
      'familyName': instance.familyName,
      'givenName': instance.givenName,
      'organizationName': instance.organizationName,
      'phoneNumber': instance.phoneNumber,
    };
