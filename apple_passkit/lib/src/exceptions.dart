import 'package:flutter/services.dart';

import 'error_codes.dart';

class PkPassEmptyException implements Exception {}

/// Indicates an issue during adding of a PkPass
class ApplePassKitException extends PlatformException {
  ApplePassKitException({
    required super.code,
    super.message,
    super.details,
    super.stacktrace,
  });
}

/// Indicates that the given pass was empty
class EmptyPkPassException extends PlatformException {
  EmptyPkPassException({
    required super.code,
    super.message,
    super.details,
    super.stacktrace,
  });
}

/// Indicates that the given pass was empty
class InvalidPkPassException extends PlatformException {
  InvalidPkPassException({
    required super.code,
    super.message,
    super.details,
    super.stacktrace,
  });
}

extension FromPlatformException on PlatformException {
  Never rethrowAsApplePassKitException(StackTrace stackTrace) {
    Object exception;
    switch (code) {
      case empty:
        exception = EmptyPkPassException(
          code: code,
          message: message,
          details: details,
          stacktrace: stacktrace,
        );
      case invalidData:
        exception = InvalidPkPassException(
          code: code,
          message: message,
          details: details,
          stacktrace: stacktrace,
        );
      default:
        exception = ApplePassKitException(
          code: code,
          message: message,
          details: details,
          stacktrace: stacktrace,
        );
    }
    Error.throwWithStackTrace(exception, stackTrace);
  }
}

Future<T?> wrapWithException<T>(Future<T?> operation) async {
  try {
    return await operation;
  } on PlatformException catch (e, s) {
    e.rethrowAsApplePassKitException(s);
  }
}
