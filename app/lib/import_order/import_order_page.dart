import 'dart:io';
import 'dart:typed_data';

import 'package:app/l10n/app_localizations.dart';
import 'package:content_resolver/content_resolver.dart';
import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';
// ignore: implementation_imports
import 'package:passkit_ui/src/order/order_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class PkOrderImportSource {
  PkOrderImportSource({this.contentResolverPath, this.bytes, this.filePath})
      : assert(
          contentResolverPath != null || bytes != null || filePath != null,
        );

  final String? contentResolverPath;
  final Uint8List? bytes;
  final String? filePath;

  Future<PkOrder> getOrder() async {
    if (contentResolverPath != null) {
      final Content content =
          await ContentResolver.resolveContent(contentResolverPath!);
      return PkOrder.fromBytes(
        content.data,
        skipChecksumVerification: true,
        skipSignatureVerification: true,
      );
    } else if (bytes != null) {
      return PkOrder.fromBytes(
        bytes!,
        skipChecksumVerification: true,
        skipSignatureVerification: true,
      );
    } else if (filePath != null) {
      return PkOrder.fromBytes(
        await File(filePath!).readAsBytes(),
        skipChecksumVerification: true,
        skipSignatureVerification: true,
      );
    }
    throw Exception('No data');
  }
}

class ImportOrderPage extends StatefulWidget {
  const ImportOrderPage({super.key, required this.source});

  final PkOrderImportSource source;

  @override
  State<ImportOrderPage> createState() => _ImportOrderPageState();
}

class _ImportOrderPageState extends State<ImportOrderPage> {
  PkOrder? order;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final pkOrder = await widget.source.getOrder();
    setState(() {
      order = pkOrder;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (order == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).import),
          actions: [
            IconButton(
              // TODO(ueman): Maybe show confirmation dialog here
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    } else {
      return OrderWidget(
        order: order!,
        isOrderImport: true,
        onDeleteOrderClicked: (order) {},
        onManageOrderClicked: launchUrl,
        onVisitMerchantWebsiteClicked: launchUrl,
        onShareClicked: (order) {},
        onMarkOrderCompletedClicked: (order) {},
        onTrackingLinkClicked: launchUrl,
        onImportOrderClicked: (order) {},
      );
    }
  }
}
