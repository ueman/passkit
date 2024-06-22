import 'dart:convert';
import 'dart:ui';

import 'package:app/web_service/app_metadata.dart';
import 'package:http/http.dart';

/// Could be moved to `passkit` package, since it could be useful for its consumers too.
class AppMetadataClient {
  AppMetadataClient({Client? client}) : _client = client ?? Client();

  final Client _client;

  Uri _itunesLookupUrl(List<int> associatedUrls, Locale locale) {
    return Uri.parse('https://itunes.apple.com/').replace(
      path: 'lookup',
      queryParameters: {
        'id': associatedUrls.join(','),
        'lang': locale.languageCode,
        'country': locale.countryCode,
      },
    );
  }

  Future<List<AppMetadata>> loadAppMetaData(
    List<int> ids, {
    Locale? locale,
  }) async {
    final url = _itunesLookupUrl(ids, locale ?? const Locale('en', 'US'));
    final response = await _client.get(url);
    final responseJson = jsonDecode(response.body);
    final list = responseJson['results'] as List;
    return list.cast<Map<String, dynamic>>().map(AppMetadata.fromJson).toList();
  }
}
