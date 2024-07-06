import 'package:json_annotation/json_annotation.dart';

part 'order_application.g.dart';

/// The details of an app in the App Store.
@JsonSerializable()
class OrderApplication {
  OrderApplication({
    required this.customProductPageIdentifier,
    required this.launchURL,
    required this.storeIdentifier,
  });

  /// Creates an instance of this class from a JSON object
  factory OrderApplication.fromJson(Map<String, dynamic> json) =>
      _$OrderApplicationFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() => _$OrderApplicationToJson(this);

  /// The identifier for a custom product page. Use when linking to the App on the AppStore.
  @JsonKey(name: 'customProductPageIdentifier')
  final String? customProductPageIdentifier;

  /// A URL passed into the application at launch.
  @JsonKey(name: 'launchURL')
  final String? launchURL;

  /// (Required) The ADAM ID (store identifier) of the application.
  @JsonKey(name: 'storeIdentifier')
  final num storeIdentifier;
}
