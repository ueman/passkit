class OrderWebServiceUnsupported implements Exception {
  @override
  String toString() => "The Order file doesn't specify a 'webServiceURL' and "
      "thus there's no possibility to make a HTTP request.";
}

class OrderWebServiceAuthenticationError implements Exception {}

class OrderWebServiceUnrecognizedStatusCode implements Exception {
  OrderWebServiceUnrecognizedStatusCode(this.statusCode);

  final int statusCode;

  @override
  String toString() =>
      'OrderWebServiceUnrecognizedStatusCode(statusCode: $statusCode)';
}
