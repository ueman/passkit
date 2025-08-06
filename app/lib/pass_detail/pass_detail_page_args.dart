import 'package:passkit/passkit.dart';

class PassDetailPageArgs {
  PassDetailPageArgs(this.pass, this.showDelete);

  final PkPass pass;
  final bool showDelete;
}
