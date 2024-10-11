import 'dart:typed_data';

import 'package:archive/archive.dart';

extension ArchiveFileX on ArchiveFile {
  Uint8List get binaryContent => Uint8List.fromList(content as List<int>);
}
