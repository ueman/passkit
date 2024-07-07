import 'package:flutter/widgets.dart';
import 'package:passkit/passkit.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({super.key, required this.order});

  final PkOrder order;

  // Build the UI according to https://docs-assets.developer.apple.com/published/e5ec23af37b6a9d9cbc90e5d5f47bf8a/wallet-ot-status-on-the-way-fields@2x.png
  // https://developer.apple.com/design/human-interface-guidelines/wallet#Order-tracking
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TODO(any): Add merchant logo here
        Text(order.order.merchant.displayName),
        // TODO(any): Add date of order here
      ],
    );
  }
}
