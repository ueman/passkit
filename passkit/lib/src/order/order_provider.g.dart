// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderProvider _$OrderProviderFromJson(Map<String, dynamic> json) =>
    OrderProvider(
      displayName: json['displayName'] as String,
      trackingLogoNameDarkColorScheme:
          json['trackingLogoNameDarkColorScheme'] as String,
      trackingLogoNameLightColorScheme:
          json['trackingLogoNameLightColorScheme'] as String,
      url: Uri.parse(json['url'] as String),
    );

Map<String, dynamic> _$OrderProviderToJson(OrderProvider instance) =>
    <String, dynamic>{
      'displayName': instance.displayName,
      'trackingLogoNameDarkColorScheme':
          instance.trackingLogoNameDarkColorScheme,
      'trackingLogoNameLightColorScheme':
          instance.trackingLogoNameLightColorScheme,
      'url': instance.url.toString(),
    };
