/// Indicates that the `manifest.json` file is missing.
class MissingManifestJsonException implements Exception {
  const MissingManifestJsonException();
  @override
  String toString() => 'The PkPass has no manifest.json';
}

/// Indicates that the `pass.json` file is missing.
class MissingPassJsonException implements Exception {
  const MissingPassJsonException();
  @override
  String toString() => 'The PkPass has no pass.json';
}

/// Indicates that the bytes from which the pass or passes should be read is empty.
class EmptyBytesException implements Exception {
  const EmptyBytesException();
  @override
  String toString() => 'The list of bytes have no content';
}

/// Indicates that the pkpass archive is missing a checksum
class MissingChecksumException implements Exception {
  const MissingChecksumException();
  @override
  String toString() => 'A file in the pkpass archive is missing a checksum';
}

class ChecksumMismatchException implements Exception {
  const ChecksumMismatchException(this.fileName);

  final String fileName;

  @override
  String toString() =>
      "The checksum of $fileName doesn't match the expected checksum";
}

class SignatureMismatchException implements Exception {
  const SignatureMismatchException();
  @override
  String toString() =>
      "The signature doesn't match the given information in the pass";
}

class CertificateExpiredException implements Exception {
  const CertificateExpiredException();
  @override
  String toString() => 'The certificate used for the signature is expired';
}
