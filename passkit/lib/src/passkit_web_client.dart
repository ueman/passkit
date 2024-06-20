import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:passkit/passkit.dart';

/// This class allows you to update a [PkPass] the latest version, if the pass
/// allows it.
///
/// Docs:
/// https://developer.apple.com/documentation/walletpasses/send_an_updated_pass
class PassKitWebClient {
  PassKitWebClient({Client? client}) : _client = client ?? Client();

  final Client _client;

  /// Loads the latest version for the given pass. Throws, if the pass doesn't
  /// support being updated. To check whether a pass supports being updated,
  /// check whether [PkPass.isWebServiceAvailable] returns true.
  ///
  /// Returns null if no new pass is available.
  ///
  /// If [modifiedSince] is present, only updates after [modifiedSince] will be
  /// considered.
  // TODO: This could return a PkPass object instead
  Future<Uint8List?> getLatestVersion(
    PkPass pass, {
    DateTime? modifiedSince,
  }) async {
    if (!pass.isWebServiceAvailable()) {
      throw PassWebServiceUnsupported();
    }

    final webServiceUrl = pass.pass.webServiceURL!;
    final authenticationToken = pass.pass.authenticationToken!;

    final identifier = pass.pass.passTypeIdentifier;
    final serial = pass.pass.serialNumber;
    final endpoint = Uri.parse(webServiceUrl)
        .resolveUri(Uri(pathSegments: ['v1', 'passes', identifier, serial]));

    final response = await _client.get(
      endpoint,
      headers: {
        if (modifiedSince != null)
          'If-Modified-Since': formatHttpDate(modifiedSince),
        'Authorization': 'ApplePass $authenticationToken',
      },
    );

    switch (response.statusCode) {
      case 200:
        return response.bodyBytes;
      case 304:
        return null;
      case 401:
        // TODO: This should probably be a custom exception
        throw Exception('Authorization error');
      default:
        // TODO: This should probably be a custom exception
        throw Exception(
            'Unrecognized status code returned: ${response.statusCode}');
    }
  }
}

class PassWebServiceUnsupported implements Exception {}
