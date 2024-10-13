import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/src/order/l10n.dart';

Future<void> showOrderDetailSheet(BuildContext context, PkOrder order) {
  return showModalBottomSheet(
    context: context,
    builder: (context) => OrderDetailsModelSheet(order: order),
  );
}

class OrderDetailsModelSheet extends StatelessWidget {
  const OrderDetailsModelSheet({super.key, required this.order});

  final PkOrder order;

  @override
  Widget build(BuildContext context) {
    final payment = order.order.payment;
    final lineItems = order.order.lineItems;

    final l10n = EnOrderLocalizations();

    return ListView(
      children: [
        if (payment != null)
          Text(
            l10n.formatCurrency(payment.total.amount, payment.total.currency),
            textAlign: TextAlign.center,
            style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
          ),
        Text(
          order.order.merchant.displayName,
          textAlign: TextAlign.center,
          style: CupertinoTheme.of(context).textTheme.textStyle,
        ),
        Text(
          l10n.orderedAt(order.order.createdAt),
          textAlign: TextAlign.center,
          style: CupertinoTheme.of(context).textTheme.textStyle,
        ),
        if (lineItems != null)
          CupertinoListSection.insetGrouped(
            children: [
              for (final lineItem in lineItems)
                CupertinoListTile.notched(
                  title: Text(lineItem.title),
                  subtitle: lineItem.subtitle != null
                      ? Text(lineItem.subtitle!)
                      : null,
                  trailing: const Column(
                    children: [
                      Text(''),
                    ],
                  ),
                ),
              _Summary(summaryItems: payment?.summaryItems),
              if (payment?.total != null)
                CupertinoListTile.notched(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(l10n.total),
                      Text(
                        l10n.formatCurrency(
                          payment!.total.amount,
                          payment.total.currency,
                        ),
                      ),
                    ],
                  ),
                ),
              // Transaction is not added since the properties are marked as
              // deprecated.
            ],
          ),
      ],
    );
  }
}

class _Summary extends StatelessWidget {
  const _Summary({this.summaryItems});

  final List<PaymentSummaryItems>? summaryItems;

  @override
  Widget build(BuildContext context) {
    if (summaryItems == null) {
      return const SizedBox.shrink();
    }
    if (summaryItems!.isEmpty) {
      return const SizedBox.shrink();
    }

    final l10n = EnOrderLocalizations();

    return CupertinoListTile.notched(
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final item in summaryItems!)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(item.label),
                Text(
                  l10n.formatCurrency(item.value.amount, item.value.currency),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
