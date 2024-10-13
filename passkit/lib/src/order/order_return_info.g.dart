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

Map<String, dynamic> _$OrderReturnInfoToJson(OrderReturnInfo instance) {
  final val = <String, dynamic>{
    'returnPolicyURL': instance.returnPolicyURL.toString(),
    'displayCountdown': instance.displayCountdown,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('returnDeadline', instance.returnDeadline?.toIso8601String());
  writeNotNull('returnManagementURL', instance.returnManagementURL?.toString());
  writeNotNull('returnPolicyDescription', instance.returnPolicyDescription);
  return val;
}
