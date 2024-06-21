import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';

Future<void> showBackFieldsDialog(
  BuildContext context,
  List<FieldDict> backFields,
  List<int>? associatedStoreIdentifiers,
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
              if (associatedStoreIdentifiers?.isNotEmpty ?? false)
                const ListTile(
                  title: Text('Associated iOS Apps'),
                ),
              for (final appId in associatedStoreIdentifiers ?? [])
                ListTile(
                  title: Text(
                    'https://itunes.apple.com/us/app/keynote/id$appId',
                  ),
                  onTap: () {},
                )
            ],
          ),
        ),
      );
    },
  );
}
