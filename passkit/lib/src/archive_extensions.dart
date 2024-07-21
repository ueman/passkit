import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';
import 'package:passkit/src/pkpass/exceptions.dart';
import 'package:passkit/src/pkpass/pk_pass_image.dart';
import 'package:passkit/src/strings_parser/naive_strings_file_parser.dart';

/// Dart uses a special fast decoder when using a fused [Utf8Decoder] and [JsonDecoder].
/// This speeds up decoding.
/// See
/// - https://api.dart.dev/stable/3.4.4/dart-convert/Utf8Decoder-class.html
/// - https://github.com/dart-lang/sdk/blob/5b2ea0c7a227d91c691d2ff8cbbeb5f7f86afdb9/sdk/lib/_internal/vm/lib/convert_patch.dart#L40
final _utf8JsonDecoder = const Utf8Decoder().fuse(const JsonDecoder());

extension ArchiveX on Archive {
  List<int>? findBytesForFile(String fileName) =>
      findFile(fileName)?.content as List<int>?;

  Uint8List? findUint8ListForFile(String fileName) {
    final data = findBytesForFile(fileName);
    return data == null ? null : Uint8List.fromList(data);
  }

  Map<String, dynamic>? findFileAndReadAsJson(String fileName) {
    final bytes = findBytesForFile(fileName);
    if (bytes == null) {
      return null;
    }
    return _utf8JsonDecoder.convert(bytes) as Map<String, dynamic>?;
  }

  PkImage? loadImage(String name) {
    return PkImage.fromImages(
      image1: findUint8ListForFile('$name.png'),
      image2: findUint8ListForFile('$name@2.png'),
      image3: findUint8ListForFile('$name@3.png'),
    );
  }

  Map<String, Map<String, String>> getTranslations() {
    final languageData = <String, Map<String, String>>{};

    // The Archive object doesn't have APIs to work with folders.
    // Instead the file name contains a `/` indicating the file is within a folder.
    // Example: `file.name == en.lproj/pass.strings`
    final translationFiles = files
        .where((element) => element.isFile)
        .where((file) => file.name.endsWith('.lproj/pass.strings'));

    for (final languageFile in translationFiles) {
      final language = languageFile.name.split('.').first;

      languageData[language] =
          parseStringsFile(languageFile.content as List<int>);
    }
    return languageData;
  }

  Map<String, dynamic> readManifest() {
    final manifestJson = findFileAndReadAsJson('manifest.json');
    if (manifestJson != null) {
      return manifestJson;
    } else {
      throw MissingManifestJsonException();
    }
  }

  /// To create the manifest file, recursively list the files in the package
  /// (except the manifest file and signature), calculate the SHA-1 hash of the
  /// contents of those files, and store the data in a dictionary. The keys are
  /// relative paths to the file from the pass package. The values are the SHA-1
  /// hash (hex encoded) of the data at that path. Write this dictionary to the
  /// file manifest.json at the top level of the pass package.
  ///
  /// https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/Creating.html#//apple_ref/doc/uid/TP40012195-CH4-SW1
  void checkSha1Checksums(Map<String, dynamic> manifest) {
    final filesWithoutSignatureAndManifest = files.where((file) {
      return file.name != 'signature' && file.name != 'manifest.json';
    }).toList();

    final fileInArchiveCount = filesWithoutSignatureAndManifest.length;
    final manifestCount = manifest.length;
    if (fileInArchiveCount != manifestCount) {
      throw MissingChecksumException();
    }

    for (final file in filesWithoutSignatureAndManifest) {
      final checksumInManifest = manifest[file.name] as String?;
      final digest = sha1.convert(file.content as List<int>);
      if (checksumInManifest != digest.toString()) {
        throw ChecksumMismatchException(file.name);
      }
    }
  }
}
