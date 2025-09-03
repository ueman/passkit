import 'dart:async';
import 'dart:typed_data';

import 'package:app/l10n/app_localizations.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:passkit/passkit.dart';

enum PassAssetType { icon, logo, thumbnail, strip, background }

class _PassAssetSpec {
  const _PassAssetSpec({required this.baseSize});
  final Size baseSize; // 1x size

  double get aspectRatio => baseSize.width / baseSize.height;
  List<Size> get sizes => [
        baseSize,
        Size(baseSize.width * 2, baseSize.height * 2),
        Size(baseSize.width * 3, baseSize.height * 3),
      ];
}

const Map<PassAssetType, _PassAssetSpec> _specs = {
  // Apple Wallet defaults
  PassAssetType.icon: _PassAssetSpec(baseSize: Size(29, 29)),
  PassAssetType.logo: _PassAssetSpec(baseSize: Size(160, 50)),
  PassAssetType.thumbnail: _PassAssetSpec(baseSize: Size(90, 90)),
  PassAssetType.strip: _PassAssetSpec(baseSize: Size(624, 220)),
  PassAssetType.background: _PassAssetSpec(baseSize: Size(180, 220)),
};

class PassImageResult {
  PassImageResult({required this.type, required this.image});
  final PassAssetType type;
  final PkImage image;
}

class PickPassImageDialog extends StatefulWidget {
  const PickPassImageDialog({super.key, this.initialType, this.allowedTypes});
  final PassAssetType? initialType;
  final Set<PassAssetType>? allowedTypes;

  static Future<PassImageResult?> show(
    BuildContext context, {
    PassAssetType? initialType,
    Set<PassAssetType>? allowedTypes,
  }) {
    return showDialog<PassImageResult>(
      context: context,
      builder: (_) => Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760, maxHeight: 760),
          child: PickPassImageDialog(
              initialType: initialType, allowedTypes: allowedTypes),
        ),
      ),
    );
  }

  @override
  State<PickPassImageDialog> createState() => _PickPassImageDialogState();
}

class _PickPassImageDialogState extends State<PickPassImageDialog> {
  final _cropController = CropController();
  PassAssetType _type = PassAssetType.icon;
  Uint8List? _sourceBytes;
  Uint8List? _croppedBytes;
  bool _processing = false;
  Completer<Uint8List?>? _cropCompleter;

  @override
  void initState() {
    super.initState();
    _type = widget.initialType ?? PassAssetType.icon;
    final allowed = widget.allowedTypes;
    if (allowed != null && !allowed.contains(_type)) {
      _type = allowed.first;
    }
  }

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result == null) return;
    final bytes = result.files.first.bytes;
    if (bytes == null) return;
    setState(() {
      _sourceBytes = bytes;
      _croppedBytes = null;
    });
  }

  Future<void> _onConfirm() async {
    if (_sourceBytes == null) return;
    setState(() => _processing = true);
    try {
      // Trigger crop to get cropped region bytes first.
      final cropped = await _cropNow();
      if (cropped == null) return;

      final spec = _specs[_type]!;
      final decoded = img.decodeImage(cropped);
      if (decoded == null) return;

      // Generate exact 1x/2x/3x PNGs.
      final sizes = spec.sizes;
      Uint8List encode(img.Image input, Size size) {
        final resized = img.copyResize(
          input,
          width: size.width.round(),
          height: size.height.round(),
          interpolation: img.Interpolation.cubic,
        );
        return Uint8List.fromList(img.encodePng(resized));
      }

      final image1 = encode(decoded, sizes[0]);
      final image2 = encode(decoded, sizes[1]);
      final image3 = encode(decoded, sizes[2]);

      final result = PassImageResult(
        type: _type,
        image: PkImage(image1: image1, image2: image2, image3: image3),
      );
      if (mounted) Navigator.of(context).pop(result);
    } finally {
      if (mounted) setState(() => _processing = false);
    }
  }

  Future<Uint8List?> _cropNow() async {
    if (_sourceBytes == null) return null;
    if (_croppedBytes != null) return _croppedBytes;
    _cropCompleter = Completer<Uint8List?>();
    _cropController.crop();
    // Hook to onCropped in the widget tree; we await the result here.
    return _cropCompleter!.future;
  }

  @override
  Widget build(BuildContext context) {
    final spec = _specs[_type]!;
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(l10n.pickPassImageTitle,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600)),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<PassAssetType>(
                  value: _type,
                  decoration: InputDecoration(labelText: l10n.assetType),
                  onChanged: (val) => setState(() {
                    _type = val!;
                    _croppedBytes = null;
                  }),
                  items: (widget.allowedTypes ?? PassAssetType.values.toSet())
                      .map(
                        (t) => DropdownMenuItem(
                          value: t,
                          child: Text(_labelFor(t)),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.file_open),
                label: Text(l10n.chooseImage),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (_sourceBytes == null)
            Container(
              height: 320,
              alignment: Alignment.center,
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: Text(l10n.noImageSelected),
            )
          else
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Crop(
                      image: _sourceBytes!,
                      controller: _cropController,
                      aspectRatio: spec.aspectRatio,
                      onCropped: (cropResult) {
                        if (cropResult is CropSuccess) {
                          setState(
                              () => _croppedBytes = cropResult.croppedImage);
                          final c = _cropCompleter;
                          if (c != null && !c.isCompleted) {
                            c.complete(cropResult.croppedImage);
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  _SpecBar(spec: spec),
                ],
              ),
            ),
          const SizedBox(height: 12),
          Row(
            children: [
              OutlinedButton(
                onPressed:
                    _processing ? null : () => Navigator.of(context).pop(),
                child: Text(l10n.cancel),
              ),
              const Spacer(),
              FilledButton.icon(
                onPressed:
                    (_sourceBytes == null || _processing) ? null : _onConfirm,
                icon: _processing
                    ? const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.check),
                label: Text(l10n.useImage),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _labelFor(PassAssetType t) {
    final l10n = AppLocalizations.of(context);
    switch (t) {
      case PassAssetType.icon:
        return l10n.pickIcon;
      case PassAssetType.logo:
        return l10n.pickLogo;
      case PassAssetType.thumbnail:
        return l10n.pickThumbnail;
      case PassAssetType.strip:
        return l10n.pickStrip;
      case PassAssetType.background:
        return l10n.pickBackground;
    }
  }
}

class _SpecBar extends StatelessWidget {
  const _SpecBar({required this.spec});
  final _PassAssetSpec spec;

  @override
  Widget build(BuildContext context) {
    final sizes = spec.sizes;
    String fmt(Size s) => '${s.width.toInt()}x${s.height.toInt()}';
    return Row(
      children: [
        Text('Aspect ${spec.aspectRatio.toStringAsFixed(3)}'),
        const SizedBox(width: 12),
        const Text('•'),
        const SizedBox(width: 12),
        Text('1x ${fmt(sizes[0])}'),
        const SizedBox(width: 8),
        Text('2x ${fmt(sizes[1])}'),
        const SizedBox(width: 8),
        Text('3x ${fmt(sizes[2])}'),
      ],
    );
  }
}
