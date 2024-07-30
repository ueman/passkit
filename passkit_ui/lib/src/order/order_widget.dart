import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/src/extensions/pk_pass_image_extension.dart';
import 'package:passkit_ui/src/order/l10n.dart';
import 'package:passkit_ui/src/order/order_details_model_sheet.dart';
import 'package:passkit_ui/src/widgets/squircle.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({
    super.key,
    required this.order,
    required this.isOrderImport,
    required this.onManageOrderClicked,
    required this.onVisitMerchantWebsiteClicked,
    required this.onShareClicked,
    required this.onDeleteOrderClicked,
    required this.onMarkOrderCompletedClicked,
    required this.onTrackingLinkClicked,
    required this.onImportOrderClicked,
  });

  final PkOrder order;

  /// When this is an import, the navigation bar shows a cancle and track button.
  /// When this is not an import, the navigation bar shows, depending on the status,
  /// a mark as completed button, a share button, and a delete order button.
  final bool isOrderImport;
  final ValueChanged<Uri> onManageOrderClicked;
  final ValueChanged<Uri> onVisitMerchantWebsiteClicked;
  final ValueChanged<Uri> onTrackingLinkClicked;
  final ValueChanged<PkOrder> onShareClicked;
  final ValueChanged<PkOrder> onDeleteOrderClicked;
  final ValueChanged<PkOrder> onMarkOrderCompletedClicked;
  final ValueChanged<PkOrder> onImportOrderClicked;

  // Build the UI according to https://docs-assets.developer.apple.com/published/e5ec23af37b6a9d9cbc90e5d5f47bf8a/wallet-ot-status-on-the-way-fields@2x.png
  // https://developer.apple.com/design/human-interface-guidelines/wallet#Order-tracking
  @override
  Widget build(BuildContext context) {
    final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);
    final l10n = EnOrderLocalizations();

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(order.order.merchant.displayName),
        leading: isOrderImport
            ? CupertinoButton(
                onPressed: () => Navigator.maybePop(context),
                padding: EdgeInsets.zero,
                child: Text(l10n.cancel),
              )
            : null,
        trailing: isOrderImport
            ? CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => onImportOrderClicked(order),
                child: Text(l10n.track),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => onShareClicked(order),
                    icon: Icon(Icons.adaptive.share),
                  ),
                  IconButton(
                    onPressed: () => onShareClicked(order),
                    icon: Icon(Icons.adaptive.more_outlined),
                  ),
                ],
              ),
      ),
      backgroundColor:
          CupertinoColors.systemGroupedBackground.resolveFrom(context),
      child: ListView(
        children: [
          if (order.order.merchant.logo != null)
            Padding(
              padding: const EdgeInsets.all(20),
              child: Squircle(
                radius: 20,
                child: Image.memory(
                  order
                      .loadImage(order.order.merchant.logo!)
                      .forCorrectPixelRatio(devicePixelRatio),
                  fit: BoxFit.contain,
                  width: 150,
                  height: 150,
                ),
              ),
            ),
          Text(
            order.order.merchant.displayName,
            textAlign: TextAlign.center,
            style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
          ),
          Text(
            l10n.orderedAt(order.order.createdAt),
            textAlign: TextAlign.center,
            style: CupertinoTheme.of(context)
                .textTheme
                .textStyle
                .copyWith(color: CupertinoColors.systemGrey),
          ),
          if (order.order.orderProvider?.displayName != null)
            CupertinoListTile(
              title: Text(l10n.courier),
              subtitle: Text(order.order.orderProvider!.displayName),
            ),
          if (order.order.fulfillments != null)
            for (final fulfillment in order.order.fulfillments!)
              _FulfillmentSection(
                fulfillment: fulfillment,
                order: order,
                onTrackingLinkClicked: onTrackingLinkClicked,
              ),
          DetailsSection(order: order),
          InfoSection(
            order: order,
            onManageOrderClicked: onManageOrderClicked,
            onVisitMerchantWebsiteClicked: onVisitMerchantWebsiteClicked,
          ),
        ],
      ),
    );
  }
}

class DetailsSection extends StatelessWidget {
  const DetailsSection({super.key, required this.order});

  final PkOrder order;

  @override
  Widget build(BuildContext context) {
    final l10n = EnOrderLocalizations();

    return CupertinoListSection.insetGrouped(
      header: Text(l10n.details),
      children: [
        CupertinoContextMenu(
          actions: [
            CupertinoContextMenuAction(
              onPressed: () => Clipboard.setData(
                ClipboardData(text: order.order.orderIdentifier),
              ),
              isDefaultAction: true,
              trailingIcon: CupertinoIcons.number,
              child: const Text('Copy Order Number'),
            ),
          ],
          child: CupertinoListTile.notched(
            title: Text(l10n.orderId),
            subtitle: Text(order.order.orderIdentifier),
          ),
        ),
        if (order.order.payment != null)
          CupertinoListTile.notched(
            title: Text(l10n.orderTotal),
            subtitle: order.order.payment == null
                ? null
                : Text(
                    l10n.formatCurrency(
                      order.order.payment!.total.amount,
                      order.order.payment!.total.currency,
                    ),
                  ),
            trailing: const CupertinoListTileChevron(),
            onTap: () => showOrderDetailSheet(context, order),
          ),
      ],
    );
  }
}

class InfoSection extends StatelessWidget {
  const InfoSection({
    super.key,
    required this.order,
    required this.onManageOrderClicked,
    required this.onVisitMerchantWebsiteClicked,
  });

  final PkOrder order;
  final ValueChanged<Uri> onManageOrderClicked;
  final ValueChanged<Uri> onVisitMerchantWebsiteClicked;

  @override
  Widget build(BuildContext context) {
    final l10n = EnOrderLocalizations();

    const linkColor = CupertinoColors.link;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CupertinoListSection.insetGrouped(
          children: [
            CupertinoListTile.notched(
              title: Text(
                l10n.manageOrder,
                style: const TextStyle(color: linkColor),
              ),
              trailing:
                  const Icon(CupertinoIcons.arrow_up_right, color: linkColor),
              onTap: () => onManageOrderClicked(order.order.orderManagementURL),
            ),
            CupertinoListTile.notched(
              title: Text(
                l10n.visitMerchantWebsite,
                style: const TextStyle(color: linkColor),
              ),
              trailing: const Icon(CupertinoIcons.compass, color: linkColor),
              onTap: () =>
                  onVisitMerchantWebsiteClicked(order.order.merchant.url),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 8),
          child: Text(
            l10n.merchantIsResponsibleNote,
            textAlign: TextAlign.center,
            style: CupertinoTheme.of(context)
                .textTheme
                .textStyle
                .copyWith(color: CupertinoColors.systemGrey),
          ),
        ),
      ],
    );
  }
}

class _FulfillmentSection extends StatelessWidget {
  const _FulfillmentSection({
    required this.fulfillment,
    required this.order,
    required this.onTrackingLinkClicked,
  });

  final Object fulfillment;
  final PkOrder order;
  final ValueChanged<Uri> onTrackingLinkClicked;

  @override
  Widget build(BuildContext context) {
    return switch (fulfillment) {
      OrderShippingFulfillment shipping => _OrderShippingFulfillmentWidget(
          fulfillment: shipping,
          order: order,
          onTrackingLinkClicked: onTrackingLinkClicked,
        ),
      OrderPickupFulfillment orderPickup =>
        _OrderPickupFulfillmentWidget(fulfillment: orderPickup),
      _ => const SizedBox.shrink()
    };
  }
}

class _OrderShippingFulfillmentWidget extends StatelessWidget {
  const _OrderShippingFulfillmentWidget({
    required this.fulfillment,
    required this.order,
    required this.onTrackingLinkClicked,
  });

  final OrderShippingFulfillment fulfillment;
  final PkOrder order;
  final ValueChanged<Uri> onTrackingLinkClicked;

  @override
  Widget build(BuildContext context) {
    final l10n = EnOrderLocalizations();
    final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);

    return CupertinoListSection.insetGrouped(
      children: [
        CupertinoListTile(
          title: Text(fulfillment.status.name),
          subtitle: Text(fulfillment.deliveredAt?.toString() ?? ''),
          trailing: const Icon(
            CupertinoIcons.check_mark_circled_solid,
            color: CupertinoColors.systemGreen,
          ),
        ),
        if (fulfillment.notes != null)
          CupertinoListTile(
            title: Text(l10n.from(order.order.merchant.displayName)),
            subtitle: Text(fulfillment.notes!),
          ),
        if (fulfillment.carrier != null)
          CupertinoListTile.notched(
            title: Text(l10n.courier),
            subtitle: Text(fulfillment.carrier!),
          ),
        if (fulfillment.trackingNumber != null)
          CupertinoListTile.notched(
            title: Text(l10n.trackingId),
            subtitle: Text(fulfillment.trackingNumber!),
          ),
        if (fulfillment.trackingURL != null)
          CupertinoListTile.notched(
            title: Text(
              l10n.trackShipment,
              style: const TextStyle(color: CupertinoColors.link),
            ),
            onTap: () => onTrackingLinkClicked(fulfillment.trackingURL!),
          ),
        if (fulfillment.lineItems != null)
          for (final lineItem in fulfillment.lineItems!)
            CupertinoListTile.notched(
              leading: lineItem.image != null
                  ? Image.memory(
                      order
                          .loadImage(lineItem.image!)
                          .forCorrectPixelRatio(devicePixelRatio),
                      fit: BoxFit.contain,
                      width: 150,
                      height: 150,
                    )
                  : null,
              title: Text(lineItem.title),
              subtitle:
                  lineItem.subtitle != null ? Text(lineItem.subtitle!) : null,
            ),
      ],
    );
  }
}

class _OrderPickupFulfillmentWidget extends StatelessWidget {
  const _OrderPickupFulfillmentWidget({required this.fulfillment});

  final OrderPickupFulfillment fulfillment;

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
