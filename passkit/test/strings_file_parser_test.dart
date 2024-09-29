import 'package:passkit/src/strings/naive_strings_file_parser.dart';
import 'package:test/test.dart';

// Taken from https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/Creating.html
final _testString = '''"origin_SVQ" = "Sevilla";
"destination_LHR" = "Londres";
''';

// Taken from https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/LoadingResources/Strings/Strings.html
final _testStringWithComments = '''/* Insert Element menu item */
"Insert Element" = "Insert Element";
/* Error string used for unknown error types. */
"ErrorString_1" = "An unknown error occurred.";
''';

void main() {
  test('naiveStringsFileParser() parses example correctly', () {
    final keyValue = naiveStringsFileParser(_testString);
    expect(keyValue, {
      'origin_SVQ': 'Sevilla',
      'destination_LHR': 'Londres',
    });
  });

  test(
      'naiveStringsFileParser() parsess example correctly despite comments in it',
      () {
    final keyValue = naiveStringsFileParser(_testStringWithComments);
    expect(keyValue, {
      'Insert Element': 'Insert Element',
      'ErrorString_1': 'An unknown error occurred.',
    });
  });
}
