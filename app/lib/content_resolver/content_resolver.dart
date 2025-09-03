import 'dart:typed_data';

import '_web_content_resolver.dart'
    if (dart.library.io) '_io_content_resolver.dart'
    as resolver;

Future<Uint8List> fromPath(String path) async {
  return resolver.fromPath(path);
}
