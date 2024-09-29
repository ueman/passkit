/// https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/LoadingResources/Strings/Strings.html
/// https://localizely.com/apple-strings-file/
String toStringsFile(Map<String, String> pairs) {
  return pairs.entries.map(_encoder).join('\n');
}

String _encoder(MapEntry<String, String> entry) {
  final key = entry.key;
  final value = entry.value
      .replaceAll('\\', '\\\\')
      .replaceAll('\n', '\\n')
      .replaceAll('"', '\\"');

  return '"$key" = "$value";';
}
