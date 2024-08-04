import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:app/pass_backside/app_metadata_tile.dart';
import 'package:app/pass_backside/placemark_tile.dart';
import 'package:app/web_service/app_meta_data_client.dart';
import 'package:app/web_service/app_metadata.dart';
import 'package:app/widgets/squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/passkit_ui.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart' as p;

class PassBackSidePageArgs {
  PassBackSidePageArgs(this.pass, this.showDelete);

  final PkPass pass;
  final bool showDelete;
}

class PassBacksidePage extends StatefulWidget {
  const PassBacksidePage({
    super.key,
    required this.pass,
    required this.showDelete,
  });

  final PkPass pass;
  final bool showDelete;

  @override
  State<PassBacksidePage> createState() => _PassBacksidePageState();

  static List<FieldDict>? _backfieldsForPassType(PkPass pass) {
    return switch (pass.type) {
      PassType.boardingPass => pass.pass.boardingPass?.backFields,
      PassType.coupon => pass.pass.coupon?.backFields,
      PassType.eventTicket => pass.pass.eventTicket?.backFields,
      PassType.generic => pass.pass.generic?.backFields,
      PassType.storeCard => pass.pass.storeCard?.backFields,
      PassType.unknown => null,
    };
  }
}

class _PassBacksidePageState extends State<PassBacksidePage> {
  List<AppMetadata> associatedApps = [];
  List<geocoding.Placemark> relevantLocations = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _loadAssociatedApps();
      _loadRelevantLocations();
    });
  }

  Future<void> _loadAssociatedApps() async {
    final associatedStoreIds =
        widget.pass.pass.associatedStoreIdentifiers ?? [];
    if (associatedStoreIds.isEmpty) {
      return;
    }
    final locale = Localizations.localeOf(context);
    final associatedApps = await AppMetadataClient()
        .loadAppMetaData(associatedStoreIds, locale: locale);
    setState(() {
      this.associatedApps = associatedApps;
    });
  }

  Future<void> _loadRelevantLocations() async {
    if (!(Platform.isAndroid || Platform.isIOS)) {
      return;
    }
    final locations = widget.pass.pass.locations;
    if (locations == null || locations.isEmpty) {
      return;
    }
    final locale = Localizations.localeOf(context);
    await geocoding.setLocaleIdentifier(locale.toLanguageTag());
    final relevantLocations = <geocoding.Placemark>[];
    for (final location in locations) {
      try {
        final placemark = await geocoding.placemarkFromCoordinates(
          location.latitude,
          location.longitude,
        );
        relevantLocations.add(placemark.first);
      } catch (e, s) {
        log('$e\n$s');
      }
    }
    setState(() {
      this.relevantLocations = relevantLocations;
    });
  }

  @override
  Widget build(BuildContext context) {
    final backfields = PassBacksidePage._backfieldsForPassType(widget.pass);
    final associatedStoreIdentifiers =
        widget.pass.pass.associatedStoreIdentifiers;
    final sharingAllowed = !(widget.pass.pass.sharingProhibited ?? false);

    return Scaffold(
      appBar: AppBar(
        title: widget.pass.icon != null
            ? Squircle(
                radius: 10,
                child: Image.memory(
                  widget.pass.icon!.fromMultiplier(3),
                  fit: BoxFit.contain,
                  height: kToolbarHeight *
                      (2 / 3), // unscientific calculation, but looks good
                ),
              )
            : null,
        actions: [
          if (sharingAllowed)
            IconButton(
              icon: Icon(Icons.adaptive.share),
              onPressed: _sharePass,
            ),
          IconButton(
            icon: const Icon(Icons.image),
            onPressed: _sharePassAsImage,
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(title: Text(widget.pass.pass.description)),
          if (backfields?.isNotEmpty ?? false) const Divider(),
          for (final entry in (backfields ?? <FieldDict>[]))
            ListTile(
              title: Text(entry.label ?? ''),
              subtitle: Linkify(
                text: entry.formatted() ?? '',
                onOpen: (link) => launchUrl(Uri.parse(link.url)),
              ),
            ),
          if (associatedStoreIdentifiers?.isNotEmpty ?? false) ...[
            const Divider(),
            ListTile(
              title: Text(AppLocalizations.of(context).associatediOSApps),
              subtitle: Text(
                AppLocalizations.of(context).associatediOSAppsDisclaimer,
              ),
            ),
            // If this associatedApps empty, it's either due to no associated apps,
            // or the apps not being available in the users region
            for (final app in associatedApps)
              AppMetadataTile(
                metadata: app,
                onAppTap: _onAppClick,
              ),
            if (widget.pass.pass.appLaunchURL != null)
              ListTile(
                title: Text(AppLocalizations.of(context).associatediOSApps),
                subtitle: Text(
                  AppLocalizations.of(context).associatediOSAppsDisclaimer,
                ),
                onTap: () {
                  final appLaunchUrl = widget.pass.pass.appLaunchURL!;
                  final url = Uri.parse(appLaunchUrl);
                  launchUrl(url);
                },
              ),
          ],
          if (widget.pass.pass.locations != null &&
              widget.pass.pass.locations!.isNotEmpty) ...[
            const Divider(),
            for (final placemark in relevantLocations)
              PlacemarkTile(
                placemark: placemark,
                onPlacemarkTap: (_) {},
              ),
          ],
          if (widget.showDelete) ...[
            const Divider(),
            ListTile(
              title: Text(
                MaterialLocalizations.of(context).deleteButtonTooltip,
                style: const TextStyle(color: Colors.red),
              ),
              onTap: () {},
            ),
          ],
        ],
      ),
    );
  }

  void _sharePass() {
    final data = Uint8List.fromList(widget.pass.sourceData);
    Share.shareXFiles([XFile.fromData(data)]);
  }

  void _sharePassAsImage() async {
    final name = widget.pass.pass.serialNumber;
    final imageData = await exportPassAsImage(widget.pass);
    if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
      final dir = await getApplicationDocumentsDirectory();

      await File(p.join(dir.path, '$name.png')).writeAsBytes(imageData!);
    } else {
      if (imageData != null) {
        await Share.shareXFiles(
          [XFile.fromData(imageData, name: 'pass.png', mimeType: 'image/png')],
        );
      }
    }
  }

  void _onAppClick(Uri url) {
    launchUrl(url);
  }
}
