import 'package:content_resolver/content_resolver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/passkit_ui.dart';
import 'package:url_launcher/url_launcher.dart';

class PkOrderImportSource {
  PkOrderImportSource({this.path, this.bytes})
      : assert(path != null || bytes != null);

  final String? path;
  final List<int>? bytes;

  Future<PkOrder> getOrder() async {
    if (path != null) {
      final Content content = await ContentResolver.resolveContent(path!);
      return PkOrder.fromBytes(content.data, skipVerification: true);
    } else if (bytes != null) {
      return PkOrder.fromBytes(bytes!, skipVerification: true);
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
              onPressed: () => context.pop(),
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
