import 'package:json_annotation/json_annotation.dart';

part 'nfc.g.dart';

/// Information about the NFC payload passed to an Apple Pay terminal.
@JsonSerializable(includeIfNull: false)
class Nfc {
  Nfc({
    required this.message,
    this.encryptionPublicKey,
    this.requiresAuthentication,
  });

  factory Nfc.fromJson(Map<String, dynamic> json) => _$NfcFromJson(json);

  Map<String, dynamic> toJson() => _$NfcToJson(this);

  /// Required. The payload to be transmitted to the Apple Pay terminal.
  /// Must be 64 bytes or less. Messages longer than 64 bytes are truncated by
  /// the system.
  final String message;

  /// Optional. The public encryption key used by the Value Added Services
  /// protocol. Use a Base64 encoded X.509 SubjectPublicKeyInfo structure
  /// containing a ECDH public key for group P256.
  final String? encryptionPublicKey;

  /// A Boolean value that indicates whether the NFC pass requires
  /// authentication. The default value is false. A value of true requires the
  /// user to authenticate for each use of the NFC pass.
  ///
  /// This key is valid in iOS 13.1 and later. Set sharingProhibited to  `true`
  /// to prevent users from sharing passes with older iOS versions and bypassing
  /// the authentication requirement.
  final bool? requiresAuthentication;
}
