import 'package:json_annotation/json_annotation.dart';

part 'order_identifiers.g.dart';

@JsonSerializable()
class OrderIdentifiers {
  OrderIdentifiers({
    required this.orderIdentifiers,
    required this.lastUpdated,
  });

  factory OrderIdentifiers.fromJson(Map<String, dynamic> json) =>
      _$OrderIdentifiersFromJson(json);

  Map<String, dynamic> toJson() => _$OrderIdentifiersToJson(this);

  /// An array of order identifer strings.
  @JsonKey(name: 'orderIdentifiers')
  final List<String> orderIdentifiers;

  /// The date and time of when an order was last changed.
  final String lastUpdated;
}
