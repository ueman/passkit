import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

abstract class OrderLocalizations {
  /// Creates a [OrderLocalizations].
  const OrderLocalizations();

  String orderedAt(DateTime date);
  String get courier;
  String get trackingId;
  String get trackShipment;
  String from(String merchant);
  String get deliveredStatus;
  String get outForDeliveryStatus;
  String get orderPlacedStatus;
  String get details;
  String get orderId;
  String get orderTotal;
  String get manageOrder;
  String get visitMerchantWebsite;
  String get subtotal;
  String get coupon;
  String get tax;
  String get total;
  String get transactions;
  String status(String status);
  String get pendingStatus;
  String get amount;
  String get shareOrder;
  String get markAsComplete;
  String get deleteOrder;
  String get readyForPickup;
  String get barcode;
  String pickupTime(DateTime from, DateTime to);
  String get pickup;
  String get pickupInstructions;
  String get pickupWindow;
  String get cancelledStatus;
  String formatCurrency(double amount, String currency);

  /// Merchant is responsible for the order, order details and receipt details.
  String get merchantIsResponsibleNote;

  /// This method is used to obtain a localized instance of
  /// [OrderLocalizations].
  static OrderLocalizations of(BuildContext context) {
    return Localizations.of<OrderLocalizations>(
      context,
      OrderLocalizations,
    )!;
  }
}

class EnOrderLocalizations extends OrderLocalizations {
  @override
  String orderedAt(DateTime date) {
    final dateFormat = DateFormat.yMd('en_EN');
    return 'Ordered ${dateFormat.format(date)}';
  }

  @override
  String amount = 'Amount';

  @override
  String coupon = 'Coupon';

  @override
  String courier = 'Courier';

  @override
  String deleteOrder = 'Delete Order';

  @override
  String deliveredStatus = 'Delivered';

  @override
  String details = 'Details';

  @override
  String from(String merchant) {
    return 'From $merchant';
  }

  @override
  String manageOrder = 'Manage Order';

  @override
  String markAsComplete = 'Mark as Complete';

  @override
  String merchantIsResponsibleNote =
      'Merchant is responsible for the order, order details and receipt details.';

  @override
  String orderId = 'Order ID';

  @override
  String orderPlacedStatus = 'Order placed';

  @override
  String orderTotal = 'Order total';

  @override
  String outForDeliveryStatus = 'Out for delivery';

  @override
  String pendingStatus = 'Pending';

  @override
  String shareOrder = 'Share order';

  @override
  String status(String status) {
    return 'Status $status';
  }

  @override
  String subtotal = 'Subtotal';

  @override
  String tax = 'Tax';

  @override
  String total = 'Total';

  @override
  String trackShipment = 'Track Shipment';

  @override
  String trackingId = 'Tracking ID';

  @override
  String transactions = 'Transactions';

  @override
  String visitMerchantWebsite = 'Visit merchant website';

  @override
  String barcode = 'Barcode';

  @override
  String pickup = 'Pickup';

  @override
  String pickupInstructions = 'Pickup Instructions';

  @override
  String pickupTime(DateTime from, DateTime to) {
    // Date, time from - to
    return 'Pickup from $from ';
  }

  @override
  String readyForPickup = 'Ready for Pickup';

  @override
  String pickupWindow = 'Pickup Window';

  @override
  String cancelledStatus = 'Cancelled';

  @override
  String formatCurrency(double amount, String currency) {
    final numberFormat = NumberFormat.currency(name: currency, locale: 'en_EN');
    return numberFormat.format(amount);
  }
}
