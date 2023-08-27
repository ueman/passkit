// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nfc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nfc _$NfcFromJson(Map<String, dynamic> json) => Nfc(
      message: json['message'] as String,
      encryptionPublicKey: json['encryptionPublicKey'] as String?,
    );

Map<String, dynamic> _$NfcToJson(Nfc instance) => <String, dynamic>{
      'message': instance.message,
      'encryptionPublicKey': instance.encryptionPublicKey,
    };
