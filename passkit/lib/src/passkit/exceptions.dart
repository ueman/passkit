/// Indicates that the `manifest.json` file is missing.
class MissingManifestJsonException implements Exception {
  @override
  String toString() => 'The PkPass has no manifest.json';
}

/// Indicates that the `pass.json` file is missing.
class MissingPassJsonException implements Exception {
  @override
  String toString() => 'The PkPass has no pass.json';
}

/// Indicates that the bytes from which the pass or passes should be read is empty.
class EmptyBytesException implements Exception {
  @override
  String toString() => 'The list of bytes have no content';
}

/// Indicates that the pkpass archive is missing a checksum
class MissingChecksumException implements Exception {
  @override
  String toString() => 'A file in the pkpass archive is missing a checksum';
}

class ChecksumMismatchException implements Exception {
  ChecksumMismatchException(this.fileName);

  final String fileName;
  @override
  String toString() =>
      "The checksum of $fileName doesn't match the expected checksum";
}
