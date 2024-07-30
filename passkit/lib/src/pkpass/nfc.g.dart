// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nfc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nfc _$NfcFromJson(Map<String, dynamic> json) => Nfc(
      message: json['message'] as String,
      encryptionPublicKey: json['encryptionPublicKey'] as String?,
      requiresAuthentication: json['requiresAuthentication'] as bool?,
    );

Map<String, dynamic> _$NfcToJson(Nfc instance) {
  final val = <String, dynamic>{
    'message': instance.message,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('encryptionPublicKey', instance.encryptionPublicKey);
  writeNotNull('requiresAuthentication', instance.requiresAuthentication);
  return val;
}
