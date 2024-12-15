import 'package:archive/archive.dart';
import 'package:passkit/src/pk_image.dart';

extension PkImageX on PkImage {
  void writeToArchive(Archive archive, String name) {
    if (image1 != null) {
      archive.addFile(ArchiveFile('$name.png', image1!.lengthInBytes, image1!));
    }
    if (image2 != null) {
      archive
          .addFile(ArchiveFile('$name@2x.png', image2!.lengthInBytes, image2!));
    }
    if (image3 != null) {
      archive
          .addFile(ArchiveFile('$name@3x.png', image3!.lengthInBytes, image3!));
    }

    if (localizedImages != null) {
      for (final entry in localizedImages!.entries) {
        final lang = entry.key;
        for (final image in entry.value.entries) {
          final fileName = switch (image.key) {
            1 => '$lang.lproj/$name.png',
            2 => '$lang.lproj/$name@2x.png',
            3 => '$lang.lproj/$name@3x.png',
            _ => throw Exception('This case should never happen'),
          };

          archive.addFile(
            ArchiveFile(fileName, image.value.lengthInBytes, image.value),
          );
        }
      }
    }
  }
}
