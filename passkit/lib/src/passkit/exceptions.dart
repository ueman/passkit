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
