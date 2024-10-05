import 'package:collection/collection.dart';
import 'package:pkcs7/pkcs7.dart';

extension CertX on X509 {
  /// Matches the pass type identifer for PkPass and the merchant identifier for
  /// orders
  String? get identifier =>
      subject.firstWhereOrNull((it) => it.key.name == 'UID')?.value as String?;

  /// Matches the team identifier
  String? get teamIdentifier => subject
      .firstWhereOrNull((it) => it.key.name == 'organizationalUnitName')
      ?.value as String?;
}
