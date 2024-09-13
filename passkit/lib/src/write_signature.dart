import 'dart:typed_data';

import 'package:passkit/src/apple_wwdr_certificate.dart';
import 'package:pem/pem.dart';
import 'package:pkcs7/pkcs7.dart';
import 'package:pointycastle/pointycastle.dart';

Uint8List writeSignature(
  String userCertificate,
  Uint8List manifestBytes,
) {
  final privateKey = _createPrivateKey(userCertificate);
  final issuer = X509.fromPem(userCertificate);

  final pkcs7Builder = Pkcs7Builder();
  // Add one or more certificates
  pkcs7Builder.addCertificate(wwdrG4);

  // Create a signature information object
  final signerInfo =
      Pkcs7SignerInfoBuilder.rsa(issuer: issuer, privateKey: privateKey);

  // Add the digest to sign
  signerInfo.addSMimeDigest(digest: manifestBytes, signingTime: DateTime.now());

  // Add the signature information
  pkcs7Builder.addSignerInfo(signerInfo);

  // Add a certificate revocation list
  pkcs7Builder.addCRL(
    CertificateRevocationList.fromDer(
      Uint8List.fromList(worldwide_Developer_Relations_G4),
    ),
  );

  final pkcs7 = pkcs7Builder.build();
  return pkcs7.der;
}

RSAPrivateKey _createPrivateKey(String certificate) {
  final pem = decodePemBlocks(PemLabel.privateKey, certificate);

  final modulus =
      ASN1Object.fromBytes(Uint8List.fromList(pem[1])) as ASN1Integer;
  final exponent =
      ASN1Object.fromBytes(Uint8List.fromList(pem[3])) as ASN1Integer;
  final p = ASN1Object.fromBytes(Uint8List.fromList(pem[4])) as ASN1Integer;
  final q = ASN1Object.fromBytes(Uint8List.fromList(pem[5])) as ASN1Integer;

  return RSAPrivateKey(
    modulus.integer!,
    exponent.integer!,
    p.integer,
    q.integer,
  );
}
