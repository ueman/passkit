import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/src/order/pickup_fulfillment.dart';
import 'package:passkit_ui/src/order/shipping_fulfillment.dart';

class FulfillmentSection extends StatelessWidget {
  const FulfillmentSection({
    super.key,
    required this.fulfillment,
    required this.order,
    required this.onTrackingLinkClicked,
    required this.index,
    required this.totalOrders,
  });

  final Object fulfillment;
  final PkOrder order;
  final ValueChanged<Uri> onTrackingLinkClicked;
  final int index;
  final int totalOrders;

  @override
  Widget build(BuildContext context) {
    return switch (fulfillment) {
      OrderShippingFulfillment shipping => OrderShippingFulfillmentWidget(
          fulfillment: shipping,
          order: order,
          onTrackingLinkClicked: onTrackingLinkClicked,
          index: index,
          totalOrders: totalOrders,
        ),
      OrderPickupFulfillment orderPickup => OrderPickupFulfillmentWidget(
          fulfillment: orderPickup,
          index: index,
          totalOrders: totalOrders,
        ),
      _ => const SizedBox.shrink()
    };
  }
}
