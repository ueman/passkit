
import 'package:app/l10n/app_localizations.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

Future<Color?> showColorPickerDialog(
  BuildContext context,
  Color color,
) {
  return showDialog<Color>(
    context: context,
    builder: (BuildContext context) {
      return ColorPickerDialog(
        initialColor: color,
      );
    },
  );
}

class ColorPickerDialog extends StatefulWidget {
  const ColorPickerDialog({
    super.key,
    required this.initialColor,
  });

  final Color initialColor;

  @override
  State<ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  late Color color;

  @override
  void initState() {
    super.initState();
    color = widget.initialColor;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(l10n.pickAColor),
      content: SingleChildScrollView(
        child: ColorPicker(
          color: color,
          onColorChanged: (Color value) {
            setState(() {
              color = value;
            });
          },
          width: 44,
          height: 44,
          borderRadius: 22,
          heading: Text(
            l10n.selectColor,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          subheading: Text(
            l10n.selectColorShade,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(l10n.cancel),
          onPressed: () {
            Navigator.of(context).pop(null);
          },
        ),
        TextButton(
          child: Text(l10n.ok),
          onPressed: () {
            Navigator.of(context).pop(color);
          },
        ),
      ],
    );
  }
}
