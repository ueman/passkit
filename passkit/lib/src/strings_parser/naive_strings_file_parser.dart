/// Here's a breakdown of the pattern:
/// - r'"((?:\"|[^"])*)"': This section matches the key, which is enclosed in
///   double quotes. Inside the quotes, it captures any character sequence that
///   is either a backslash-escaped double quote or any character that is not a
///   double quote.
/// - \s?=\s?: This part matches the equals sign with optional whitespace before
///   and after it.
/// - r'"((?:\"|[^"])*)"': This section matches the value, using a similar
///   pattern to capture any character sequence within double quotes.
/// - \s?;: This last part matches optional whitespace followed by a semicolon.
final _stringsParserRegEx =
    RegExp(r'"((?:\\"|[^"])*)"\s?=\s?"((?:\\"|[^"])*)"\s?;');

/// This method uses a quite naive approach to parse Apples `strings` file
/// format with a [RegExp]. It doesn't support placeholders.
///
/// See also:
/// - https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/LoadingResources/Strings/Strings.html
/// - https://localizely.com/apple-strings-file/
Map<String, String> naiveStringsFileParser(String stringsFile) {
  final matches = _stringsParserRegEx
      .allMatches(stringsFile)
      .where((match) => match.group(1) != null && match.group(2) != null)
      .map((match) => MapEntry(match.group(1)!, match.group(2)!));

  return Map.fromEntries(matches);
}
