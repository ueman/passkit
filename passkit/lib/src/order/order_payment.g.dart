// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderPayment _$OrderPaymentFromJson(Map<String, dynamic> json) => OrderPayment(
      total:
          OrderCurrencyAmount.fromJson(json['total'] as Map<String, dynamic>),
      summaryItems: (json['summaryItems'] as List<dynamic>?)
          ?.map((e) => PaymentSummaryItems.fromJson(e as Map<String, dynamic>))
          .toList(),
      transactions: (json['transactions'] as List<dynamic>?)
          ?.map((e) => PaymentTransaction.fromJson(e as Map<String, dynamic>))
          .toList(),
      paymentMethods: (json['paymentMethods'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      status: json['status'] as String?,
      applePayTransactionIdentifiers:
          (json['applePayTransactionIdentifiers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
    );

Map<String, dynamic> _$OrderPaymentToJson(OrderPayment instance) {
  final val = <String, dynamic>{
    'total': instance.total,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('summaryItems', instance.summaryItems);
  writeNotNull('transactions', instance.transactions);
  writeNotNull('paymentMethods', instance.paymentMethods);
  writeNotNull('status', instance.status);
  writeNotNull('applePayTransactionIdentifiers',
      instance.applePayTransactionIdentifiers);
  return val;
}

PaymentTransaction _$PaymentTransactionFromJson(Map<String, dynamic> json) =>
    PaymentTransaction(
      amount:
          OrderCurrencyAmount.fromJson(json['amount'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      paymentMethod: OrderPaymentMethod.fromJson(
          json['paymentMethod'] as Map<String, dynamic>),
      status: $enumDecode(_$PaymentTransactionStatusEnumMap, json['status']),
      applePayTransactionIdentifier:
          json['applePayTransactionIdentifier'] as String?,
      transactionType:
          $enumDecode(_$PaymentTransactionTypeEnumMap, json['transactionType']),
      receipt: json['receipt'] as String?,
    );

Map<String, dynamic> _$PaymentTransactionToJson(PaymentTransaction instance) {
  final val = <String, dynamic>{
    'amount': instance.amount,
    'createdAt': instance.createdAt.toIso8601String(),
    'paymentMethod': instance.paymentMethod,
    'status': _$PaymentTransactionStatusEnumMap[instance.status]!,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'applePayTransactionIdentifier', instance.applePayTransactionIdentifier);
  val['transactionType'] =
      _$PaymentTransactionTypeEnumMap[instance.transactionType]!;
  writeNotNull('receipt', instance.receipt);
  return val;
}

const _$PaymentTransactionStatusEnumMap = {
  PaymentTransactionStatus.pending: 'pending',
  PaymentTransactionStatus.approved: 'approved',
  PaymentTransactionStatus.completed: 'completed',
  PaymentTransactionStatus.cancelled: 'cancelled',
  PaymentTransactionStatus.failed: 'failed',
};

const _$PaymentTransactionTypeEnumMap = {
  PaymentTransactionType.purchase: 'purchase',
  PaymentTransactionType.refund: 'refund',
};

OrderPaymentMethod _$OrderPaymentMethodFromJson(Map<String, dynamic> json) =>
    OrderPaymentMethod(
      displayName: json['displayName'] as String,
    );

Map<String, dynamic> _$OrderPaymentMethodToJson(OrderPaymentMethod instance) =>
    <String, dynamic>{
      'displayName': instance.displayName,
    };

PaymentSummaryItems _$PaymentSummaryItemsFromJson(Map<String, dynamic> json) =>
    PaymentSummaryItems(
      label: json['label'] as String,
      value:
          OrderCurrencyAmount.fromJson(json['value'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaymentSummaryItemsToJson(
        PaymentSummaryItems instance) =>
    <String, dynamic>{
      'label': instance.label,
      'value': instance.value,
    };
