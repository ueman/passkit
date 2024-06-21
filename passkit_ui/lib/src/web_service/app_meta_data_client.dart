import 'dart:convert';

import 'package:http/http.dart';
import 'package:passkit_ui/src/web_service/app_metadata.dart';

/// Could be moved to `passkit` package, since it could be useful for its consumers too.
class AppMetadataClient {
  AppMetadataClient({Client? client}) : _client = client ?? Client();

  final Client _client;

  Uri _itunesLookupUrl(List<int> associatedUrls, String lang, String country) {
    return Uri.parse('https://itunes.apple.com/')
        .replace(path: 'lookup', queryParameters: {
      'id': associatedUrls.join(','),
      'lang': lang,
      'country': country,
    });
  }

  Future<List<AppMetadata>> loadAppMetaData(
    List<int> ids, {
    String? lang,
    String? country,
  }) async {
    final url = _itunesLookupUrl(ids, lang ?? 'en', country ?? 'us');
    final response = await _client.get(url);
    final responseJson = jsonDecode(response.body);
    final list = responseJson['results'] as List;
    return list.cast<Map<String, dynamic>>().map(AppMetadata.fromJson).toList();
  }
}
