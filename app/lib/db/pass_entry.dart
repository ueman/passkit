import 'dart:typed_data';

import 'package:floor/floor.dart';

@entity
class PassEntry {
  PassEntry({
    required this.id,
    required this.description,
    required this.pass,
  });

  @primaryKey
  final String id;

  final String description;

  final Uint8List pass;
}
