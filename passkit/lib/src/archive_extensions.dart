import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';
import 'package:passkit/src/archive_file_extension.dart';
import 'package:passkit/src/pk_image.dart';
import 'package:passkit/src/pkpass/exceptions.dart';
import 'package:passkit/src/strings_parser/naive_strings_file_parser.dart';
import 'package:passkit/src/utils.dart';

extension ArchiveX on Archive {
  Uint8List? findBytesForFile(String fileName) =>
      findFile(fileName)?.binaryContent;

  Map<String, dynamic>? findFileAndReadAsJson(String fileName) {
    final bytes = findBytesForFile(fileName);
    if (bytes == null) {
      return null;
    }
    return utf8JsonDecode(bytes);
  }

  PkImage? loadImage(String name) {
    return PkImage.fromImages(
      image1: findBytesForFile('$name.png'),
      image2: findBytesForFile('$name@2.png'),
      image3: findBytesForFile('$name@3.png'),
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

      languageData[language] = parseStringsFile(languageFile.binaryContent);
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
      final digest = sha1.convert(file.binaryContent);
      if (checksumInManifest != digest.toString()) {
        throw ChecksumMismatchException(file.name);
      }
    }
  }

  Uint8List createManifest() {
    final manifest = <String, String>{};
    for (final file in files) {
      manifest[file.name] = sha1.convert(file.binaryContent).toString();
    }

    final manifestContent = utf8JsonEncode(manifest);
    final manifestFile = ArchiveFile(
      'manifest.json',
      manifestContent.length,
      manifestContent,
    );
    addFile(manifestFile);
    return Uint8List.fromList(manifestContent);
  }
}
