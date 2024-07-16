import 'package:flutter/cupertino.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/src/order/l10n.dart';
import 'package:passkit_ui/src/order/order_details_model_sheet.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({super.key, required this.order});

  final PkOrder order;

  // Build the UI according to https://docs-assets.developer.apple.com/published/e5ec23af37b6a9d9cbc90e5d5f47bf8a/wallet-ot-status-on-the-way-fields@2x.png
  // https://developer.apple.com/design/human-interface-guidelines/wallet#Order-tracking
  @override
  Widget build(BuildContext context) {
    final l10n = EnOrderLocalizations();
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(order.order.merchant.displayName),
      ),
      backgroundColor:
          CupertinoColors.systemGroupedBackground.resolveFrom(context),
      child: ListView(
        children: [
          //Image.memory(order.o)
          Text(
            order.order.merchant.displayName,
            textAlign: TextAlign.center,
            style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
          ),
          Text(
            l10n.orderedAt(order.order.createdAt),
            textAlign: TextAlign.center,
            style: CupertinoTheme.of(context).textTheme.textStyle,
          ),
          if (order.order.orderProvider?.displayName != null)
            CupertinoListTile(
              title: Text(l10n.courier),
              subtitle: Text(order.order.orderProvider!.displayName),
            ),
          if (order.order.fulfillments != null)
            for (final fulfillment in order.order.fulfillments!)
              _FulfillmentSection(fulfillment: fulfillment, order: order),
          DetailsSection(order: order),
          InfoSection(
            order: order,
            onManageOrderClicked: (_) {},
            onVisitMerchantWebsiteClicked: (_) {},
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
        CupertinoListTile.notched(
          title: Text(l10n.orderId),
          subtitle: Text(order.order.orderIdentifier),
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
          padding: const EdgeInsets.all(8.0),
          child: Text(
            l10n.merchantIsResponsibleNote,
            textAlign: TextAlign.center,
            style: CupertinoTheme.of(context).textTheme.textStyle,
          ),
        ),
      ],
    );
  }
}

class _FulfillmentSection extends StatelessWidget {
  const _FulfillmentSection({required this.fulfillment, required this.order});

  final Object fulfillment;
  final PkOrder order;

  @override
  Widget build(BuildContext context) {
    return switch (fulfillment) {
      OrderShippingFulfillment shipping =>
        _OrderShippingFulfillmentWidget(fulfillment: shipping, order: order),
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
  });

  final OrderShippingFulfillment fulfillment;
  final PkOrder order;

  @override
  Widget build(BuildContext context) {
    final l10n = EnOrderLocalizations();

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
            onTap: () {},
          ),
        if (fulfillment.lineItems != null)
          for (final lineItem in fulfillment.lineItems!)
            CupertinoListTile.notched(
              title: Text(lineItem.title),
              subtitle:
                  lineItem.subtitle != null ? Text(lineItem.subtitle!) : null,
              onTap: () {},
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
