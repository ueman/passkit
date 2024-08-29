import 'package:app/db/db.dart';
import 'package:flutter/foundation.dart';
import 'package:passkit/passkit.dart';

final passListNotifier = PassListNotifier();

class PassListNotifier extends ChangeNotifier {
  List<PkPass>? passes;

  Future<void> loadPasses() async {
    final dbPasses = await db.passEntryDao.findAll();
    passes = dbPasses.map((p) {
      return PkPass.fromBytes(
        p.pass,
        skipChecksumVerification: true,
        skipSignatureVerification: true,
      );
    }).toList();
    notifyListeners();
  }
}
