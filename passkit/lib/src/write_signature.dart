import 'dart:typed_data';

import 'package:passkit/src/apple_wwdr_certificate.dart';
import 'package:pem/pem.dart';
import 'package:pkcs7/pkcs7.dart';
import 'package:pointycastle/pointycastle.dart';

/// [pkPassCertPem] is the certificate to be used to sign the PkPass file.
///
/// [privateKeyPem] is the private key PEM file. Right now,
/// it's only supported if it's not password protected.
///
/// [manifestBytes] are the content of the manifest.json file.
///
/// Follow this guide on how to create [pkPassCertPem] and [privateKeyPem],
/// starting at the `Can I have your signature, please?` section:
/// https://www.kodeco.com/2855-beginning-passbook-in-ios-6-part-1-2?page=4#toc-anchor-011
//
// TODO(any): Add pkPassCertPem checks
//            similar to the signature_verification.dart file, the identifier
//            and teamIdentifier should match. But one step at a time.
Uint8List writeSignature(
  String pkPassCertPem,
  String privateKeyPem,
  // manifestBytes may need to be converted to a sha256 and then passed on as the digest
  Uint8List manifestBytes,
) {
  final privateKey = _createPrivateKey(privateKeyPem);
  final issuer = X509.fromPem(pkPassCertPem);

  final pkcs7Builder = Pkcs7Builder();

  pkcs7Builder.addCertificate(issuer);
  pkcs7Builder.addCertificate(wwdrG4);

  final signerInfo = Pkcs7SignerInfoBuilder.rsa(
    issuer: issuer,
    privateKey: privateKey,
    digestAlgorithm: HashAlgorithm.sha1,
  );

  signerInfo.addSMimeDigest(digest: manifestBytes, signingTime: DateTime.now());
  pkcs7Builder.addSignerInfo(signerInfo);

  final pkcs7 = pkcs7Builder.build();
  return pkcs7.der;
}

RSAPrivateKey _createPrivateKey(String privateKeyPem) {
  final pem = decodePemBlocks(PemLabel.privateKey, privateKeyPem);

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
