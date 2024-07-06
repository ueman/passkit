import 'package:json_annotation/json_annotation.dart';

part 'order_provider.g.dart';

@JsonSerializable()
class OrderProvider {
  OrderProvider({
    required this.displayName,
    required this.trackingLogoNameDarkColorScheme,
    required this.trackingLogoNameLightColorScheme,
    required this.url,
  });

  /// Creates an instance of this class from a JSON object
  factory OrderProvider.fromJson(Map<String, dynamic> json) =>
      _$OrderProviderFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() => _$OrderProviderToJson(this);

  /// (Required) The localized display name of the order provider platform.
  @JsonKey(name: 'displayName')
  final String displayName;

  /// (Required) The name of the logo image for the order provider that’s
  /// intended for the dark color scheme. When the shipping fulfilment has a
  /// trackingURL, it uses this image.
  @JsonKey(name: 'trackingLogoNameDarkColorScheme')
  final String trackingLogoNameDarkColorScheme;

  /// (Required) The name of the logo image for the order provider that’s
  /// intended for the light color scheme. When the shipping fulfilment has a
  /// trackingURL, it uses this image.
  @JsonKey(name: 'trackingLogoNameLightColorScheme')
  final String trackingLogoNameLightColorScheme;

  /// (Required) The URL of the order provder platform.
  @JsonKey(name: 'url')
  final Uri url;
}
