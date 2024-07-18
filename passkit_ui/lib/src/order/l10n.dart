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
  String get markOrderCompleted;
  String get track;
  String get cancel;

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
  final String amount = 'Amount';

  @override
  final String coupon = 'Coupon';

  @override
  final String courier = 'Courier';

  @override
  final String deleteOrder = 'Delete Order';

  @override
  final String deliveredStatus = 'Delivered';

  @override
  final String details = 'Details';

  @override
  String from(String merchant) {
    return 'From $merchant';
  }

  @override
  final String manageOrder = 'Manage Order';

  @override
  final String markAsComplete = 'Mark as Complete';

  @override
  final String merchantIsResponsibleNote =
      'Merchant is responsible for the order, order details and receipt details.';

  @override
  final String orderId = 'Order ID';

  @override
  final String orderPlacedStatus = 'Order placed';

  @override
  final String orderTotal = 'Order total';

  @override
  final String outForDeliveryStatus = 'Out for delivery';

  @override
  final String pendingStatus = 'Pending';

  @override
  final String shareOrder = 'Share order';

  @override
  String status(String status) {
    return 'Status $status';
  }

  @override
  final String subtotal = 'Subtotal';

  @override
  final String tax = 'Tax';

  @override
  final String total = 'Total';

  @override
  final String trackShipment = 'Track Shipment';

  @override
  final String trackingId = 'Tracking ID';

  @override
  final String transactions = 'Transactions';

  @override
  final String visitMerchantWebsite = 'Visit merchant website';

  @override
  final String barcode = 'Barcode';

  @override
  final String pickup = 'Pickup';

  @override
  final String pickupInstructions = 'Pickup Instructions';

  @override
  String pickupTime(DateTime from, DateTime to) {
    // Date, time from - to
    return 'Pickup from $from ';
  }

  @override
  final String readyForPickup = 'Ready for Pickup';

  @override
  final String pickupWindow = 'Pickup Window';

  @override
  final String cancelledStatus = 'Cancelled';

  @override
  String formatCurrency(double amount, String currency) {
    final numberFormat = NumberFormat.currency(name: currency, locale: 'en_EN');
    return numberFormat.format(amount);
  }

  @override
  final String markOrderCompleted = 'Mark as completed';

  @override
  final String track = 'Track';

  @override
  final String cancel = 'Cancel';
}
