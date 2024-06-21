import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';

Future<void> showBackFieldsDialog(
  BuildContext context,
  List<FieldDict> backFields,
) async {
  showAdaptiveDialog<void>(
    context: context,
    builder: (_) {
      return AlertDialog.adaptive(
        actions: [
          TextButton(
            onPressed: () => Navigator.maybePop(context),
            child: Text(MaterialLocalizations.of(context).closeButtonLabel),
          )
        ],
        content: SingleChildScrollView(
          child: Column(
            children: [
              for (final entry in backFields)
                ListTile(
                  title: Text(entry.label ?? ''),
                  subtitle: Text(entry.value.toString()),
                ),
            ],
          ),
        ),
      );
    },
  );
}
