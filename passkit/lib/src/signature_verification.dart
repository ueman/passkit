import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:crypto/crypto.dart';
import 'package:passkit/src/apple_wwdr_certificate.dart';
import 'package:passkit/src/pkpass/exceptions.dart';
import 'package:pkcs7/pkcs7.dart';

/// [identifier] corresponds to the `passTypeIdentifier` in PkPasses or the
/// `orderTypeIdentifier` for PkOrders.
///
/// [teamIdentifier] corresponds to the `teamIdentifier` in PkPasses or the
/// `merchantIdentifier` for PkOrders.
//
// What about old WWDR certs? Apple seemingly accepts them just fine?
// Only make sure the signing cert matches the pass' contents?
// Should pass updates just have valid certs, or is it fine
// as long as the contents match?
bool verifySignature({
  required Uint8List signatureBytes,
  required Uint8List manifestBytes,
  required String identifier,
  required String teamIdentifier,
  DateTime? now,
  bool checkOutdatedIssuerCerts = true,
}) {
  final manifestHash = Uint8List.fromList(sha256.convert(manifestBytes).bytes);
  final pkcs7 = Pkcs7.fromDer(signatureBytes);

  if (checkOutdatedIssuerCerts) {
    for (final cert in pkcs7.certificates) {
      if (cert.notAfter.isBefore(now ?? DateTime.now())) {
        throw const CertificateExpiredException();
      }
    }
  }

  final issuerCert = pkcs7.certificates
      .firstWhereOrNull(_verifier(teamIdentifier, identifier));

  if (issuerCert == null) {
    throw const SignatureMismatchException();
  }

  // there must be a certificate in pkcs7.certificates which
  // - has a subject with a UID which matches the passTypeIdentifier
  // - has a organizationalUnitName which matches the teamIdentifier
  // there must be a certificate in there which matches an APPLE WWDR certificate

  // From https://developer.apple.com/documentation/walletpasses/building_a_pass
  // Set the passTypeIdentifier of Pass in the pass.json file to the identifier.
  // Set the serialNumber key to the unique serial number for that identifier.

  final signerInfo = pkcs7.verify([wwdrG4]);
  // final algo = signerInfo.getDigest(signerInfo.digestAlgorithm); Calculate hash based on the algo?
  return signerInfo.listEquality(manifestHash, signerInfo.messageDigest!);
}

bool Function(X509) _verifier(String teamIdentifier, String identifier) {
  return (X509 x509) {
    final identifierMatches =
        x509.subject.firstWhereOrNull((it) => it.key.name == 'UID')?.value ==
            identifier;

    final teamIdentifierMatches = x509.subject
            .firstWhereOrNull(
              (it) => it.key.name == 'organizationalUnitName',
            )
            ?.value ==
        teamIdentifier;

    return identifierMatches && teamIdentifierMatches;
  };
}
