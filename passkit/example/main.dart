import 'dart:io';

import 'package:passkit/passkit.dart';

void main() async {
  final passKitBytes = await File('pass.pkpass').readAsBytes();
  final pkPass = PkPass.fromBytes(passKitBytes);

  print(pkPass.pass.description);

  if (pkPass.isWebServiceAvailable) {
    final updatedPass = PassKitWebClient().getLatestVersion(pkPass);
    print(updatedPass);
  }
}
