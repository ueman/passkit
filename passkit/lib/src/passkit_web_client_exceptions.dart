class PassKitWebServiceUnsupported implements Exception {
  @override
  String toString() => "The PkPass file doesn't specify a 'webServiceURL' and "
      "thus there's no possibility to make a HTTP request.";
}

class PassKitWebServiceAuthenticationError implements Exception {}

class PassKitWebServiceUnrecognizedStatusCode implements Exception {
  PassKitWebServiceUnrecognizedStatusCode(this.statusCode);

  final int statusCode;

  @override
  String toString() =>
      'PassKitWebServiceUnrecognizedStatusCode(statusCode: $statusCode)';
}
