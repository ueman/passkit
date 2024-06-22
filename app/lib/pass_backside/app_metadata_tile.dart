import 'package:app/web_service/app_metadata.dart';
import 'package:flutter/material.dart';

class AppMetadataTile extends StatelessWidget {
  const AppMetadataTile({super.key, required this.metadata, this.onAppTap});

  final AppMetadata metadata;
  final ValueChanged<Uri>? onAppTap;

  @override
  Widget build(BuildContext context) {
    final pixelRatio = MediaQuery.devicePixelRatioOf(context).toInt();
    final iconUri = switch (pixelRatio) {
      1 => metadata.artworkUrl60,
      2 => metadata.artworkUrl100,
      3 => metadata.artworkUrl512,
      _ => metadata.artworkUrl100,
    };

    return ListTile(
      title: Text(metadata.name),
      subtitle: Text(metadata.genres.join(', ')),
      // TODO(ueman): Icon should be an Apple typical squircle
      leading: Image.network(iconUri.toString()),
      onTap: onAppTap == null ? null : () => onAppTap!(metadata.url),
    );
  }
}
