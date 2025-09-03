import 'package:content_resolver/content_resolver.dart';

import 'dart:typed_data';

Future<Uint8List> fromPath(String path) async {
  final Content content = await ContentResolver.resolveContent(path);
  return content.data;
}
