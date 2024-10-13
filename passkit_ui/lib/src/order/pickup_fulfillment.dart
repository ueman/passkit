import 'package:flutter/material.dart';
import 'package:passkit/passkit.dart';

class OrderPickupFulfillmentWidget extends StatelessWidget {
  const OrderPickupFulfillmentWidget({
    super.key,
    required this.fulfillment,
    required this.index,
    required this.totalOrders,
  });

  final OrderPickupFulfillment fulfillment;
  final int index;
  final int totalOrders;

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
