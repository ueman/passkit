import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/src/extensions/pk_pass_image_extension.dart';
import 'package:passkit_ui/src/order/l10n.dart';
import 'package:passkit_ui/src/widgets/squircle.dart';

class OrderShippingFulfillmentWidget extends StatelessWidget {
  const OrderShippingFulfillmentWidget({
    super.key,
    required this.fulfillment,
    required this.order,
    required this.onTrackingLinkClicked,
    required this.index,
    required this.totalOrders,
  });

  final OrderShippingFulfillment fulfillment;
  final PkOrder order;
  final ValueChanged<Uri> onTrackingLinkClicked;
  final int index;
  final int totalOrders;

  @override
  Widget build(BuildContext context) {
    final l10n = EnOrderLocalizations();
    final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);

    return CupertinoListSection.insetGrouped(
      children: [
        _header(),
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

  _StatusHeader _header() {
    return switch (fulfillment.status) {
      OrderShippingFulfillmentStatus.open => _StatusHeader(
          fulfillment: fulfillment,
          index: index,
          totalOrders: totalOrders,
          order: order,
        ),
      OrderShippingFulfillmentStatus.processing => _StatusHeader(
          fulfillment: fulfillment,
          index: index,
          totalOrders: totalOrders,
          order: order,
        ),
      OrderShippingFulfillmentStatus.onTheWay => _StatusHeader(
          fulfillment: fulfillment,
          index: index,
          totalOrders: totalOrders,
          order: order,
        ),
      OrderShippingFulfillmentStatus.outForDelivery => _StatusHeader(
          fulfillment: fulfillment,
          index: index,
          totalOrders: totalOrders,
          order: order,
        ),
      OrderShippingFulfillmentStatus.delivered => _StatusHeader(
          fulfillment: fulfillment,
          index: index,
          totalOrders: totalOrders,
          order: order,
        ),
      OrderShippingFulfillmentStatus.shipped => _StatusHeader(
          fulfillment: fulfillment,
          index: index,
          totalOrders: totalOrders,
          order: order,
        ),
      OrderShippingFulfillmentStatus.issue => _StatusHeader(
          fulfillment: fulfillment,
          index: index,
          totalOrders: totalOrders,
          order: order,
        ),
      OrderShippingFulfillmentStatus.cancelled => _StatusHeader(
          fulfillment: fulfillment,
          index: index,
          totalOrders: totalOrders,
          order: order,
        ),
    };
  }
}

class _StatusHeader extends StatelessWidget {
  const _StatusHeader({
    required this.fulfillment,
    required this.order,
    required this.index,
    required this.totalOrders,
  });

  final OrderShippingFulfillment fulfillment;
  final PkOrder order;

  final int index;
  final int totalOrders;

  @override
  Widget build(BuildContext context) {
    final l10n = EnOrderLocalizations();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.shipmentXFromY(index + 1, totalOrders),
            style: CupertinoTheme.of(context)
                .textTheme
                .textStyle
                .copyWith(color: CupertinoColors.systemGrey),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.shippingStatus(fulfillment.status),
                style: CupertinoTheme.of(context)
                    .textTheme
                    .navLargeTitleTextStyle
                    .copyWith(fontSize: 20),
              ),
              if (fulfillment.notes != null)
                CupertinoButton(
                  onPressed: () {
                    showBottomSheet(
                      context: context,
                      builder: (_) {
                        return Text(fulfillment.notes!);
                      },
                    );
                  },
                  child: const Icon(
                    CupertinoIcons.info_circle,
                    color: CupertinoColors.systemBlue,
                  ),
                ),
            ],
          ),
          Text(
            fulfillment.estimatedDeliveryAt != null
                ? l10n.estimatedDeliveryAt(fulfillment.estimatedDeliveryAt!)
                : '',
            style: CupertinoTheme.of(context).textTheme.textStyle,
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            valueColor: const AlwaysStoppedAnimation<Color>(
              CupertinoColors.systemGreen,
            ),
            minHeight: 20,
            borderRadius: BorderRadius.circular(10),
            value: fulfillment.status.toProgress(),
          ),
          if (fulfillment.statusDescription != null) ...[
            const SizedBox(height: 10),
            Squircle(
              radius: 20,
              child: ColoredBox(
                color: CupertinoColors.extraLightBackgroundGray,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        l10n.from(order.order.merchant.displayName),
                        style: CupertinoTheme.of(context)
                            .textTheme
                            .textStyle
                            .copyWith(color: CupertinoColors.systemGrey),
                      ),
                      Text(
                        fulfillment.statusDescription!,
                        style: CupertinoTheme.of(context).textTheme.textStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
