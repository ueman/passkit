import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:passkit/src/crypto/apple_wwdr_certificate.dart';
import 'package:passkit/src/crypto/certificate_extension.dart';
import 'package:passkit/src/pkpass/exceptions.dart';
import 'package:pkcs7/pkcs7.dart';
import 'package:pointycastle/pointycastle.dart';

/// [certificatePem] is the certificate to be used to sign the PkPass file.
///
/// [privateKeyPem] is the private key PEM file. Right now,
/// it's only supported if it's not password protected.
///
/// Read more about signing [here](https://github.com/ueman/passkit/blob/master/passkit/SIGNING.md).
// TODO(any): Add pkPassCertPem checks
//            similar to the signature_verification.dart file, the identifier
//            and teamIdentifier should match. But one step at a time.
Uint8List writeSignature(
  String certificatePem,
  String privateKeyPem,
  Uint8List manifestBytes,
  String identifier,
  String teamIdentifier,
  bool isPkPass,
) {
  final issuer = X509.fromPem(certificatePem);
  _ensureCertificateMatchesPass(
    issuer,
    identifier,
    teamIdentifier,
    isPkPass,
  );

  final pkcs7Builder = Pkcs7Builder();

  pkcs7Builder.addCertificate(wwdrG4);
  pkcs7Builder.addCertificate(issuer);

  final privateKey =
      encrypt.RSAKeyParser().parse(privateKeyPem) as RSAPrivateKey;

  final signerInfo = Pkcs7SignerInfoBuilder.rsa(
    issuer: issuer,
    privateKey: privateKey,
    digestAlgorithm: HashAlgorithm.sha256,
  );

  final manifestHash = Uint8List.fromList(sha256.convert(manifestBytes).bytes);

  signerInfo.addSMimeDigest(
    digest: manifestHash,
    signingTime: DateTime.now(),
  );
  pkcs7Builder.addSignerInfo(signerInfo);

  final pkcs7 = pkcs7Builder.build();
  return pkcs7.der;
}

void _ensureCertificateMatchesPass(
  X509 issuer,
  String identifier,
  String teamIdentifier,
  bool isPkPass,
) {
  final identifierMatches = issuer.identifier == identifier;
  final teamIdentifierMatches = issuer.teamIdentifier == teamIdentifier;

  if (!identifierMatches) {
    if (isPkPass) {
      throw Exception(
        "PkPass.pass.passTypeIdentifier doesn't match the certificate Pass Type ID",
      );
    } else {
      // TODO(any): Write a proper exception for orders
      throw SignatureMismatchException();
    }
  }
  if (!teamIdentifierMatches) {
    if (isPkPass) {
      throw Exception(
        "PkPass.pass.teamIdentifier doesn't match the certificate team ID",
      );
    } else {
      // TODO(any): Write a proper exception for orders
      throw SignatureMismatchException();
    }
  }
}
