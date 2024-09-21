import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:passkit/src/apple_wwdr_certificate.dart';
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
) {
  final issuer = X509.fromPem(certificatePem);

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
