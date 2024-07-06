// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_return_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderReturnInfo _$OrderReturnInfoFromJson(Map<String, dynamic> json) =>
    OrderReturnInfo(
      returnPolicyURL: Uri.parse(json['returnPolicyURL'] as String),
      displayCountdown: json['displayCountdown'] as bool? ?? false,
      returnDeadline: json['returnDeadline'] == null
          ? null
          : DateTime.parse(json['returnDeadline'] as String),
      returnManagementURL: json['returnManagementURL'] == null
          ? null
          : Uri.parse(json['returnManagementURL'] as String),
      returnPolicyDescription: json['returnPolicyDescription'] as String?,
    );

Map<String, dynamic> _$OrderReturnInfoToJson(OrderReturnInfo instance) =>
    <String, dynamic>{
      'returnPolicyURL': instance.returnPolicyURL.toString(),
      'displayCountdown': instance.displayCountdown,
      'returnDeadline': instance.returnDeadline?.toIso8601String(),
      'returnManagementURL': instance.returnManagementURL?.toString(),
      'returnPolicyDescription': instance.returnPolicyDescription,
    };
