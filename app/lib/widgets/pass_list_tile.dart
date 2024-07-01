import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/passkit_ui.dart';

// TODO(ueman): Maybe move to `package:passkit_ui`?
class PassListTile extends StatelessWidget {
  const PassListTile({super.key, required this.pass, this.onTap});

  final PkPass pass;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);
    final icon = pass.icon?.forCorrectPixelRatio(devicePixelRatio);
    return ListTile(
      // TODO(ueman): The icon should be an Apple squircle
      leading: icon == null ? null : Image.memory(icon),
      title: Text(pass.pass.description),
      subtitle: Text(pass.pass.organizationName),
      //trailing: PkPassWidget(pass: pass),
      onTap: onTap,
    );
  }
}
