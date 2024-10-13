import 'package:passkit/src/pkpass/pass_data.dart';
import 'package:passkit/src/pkpass/pkpass.dart';

class CreationFailureException implements Exception {
  const CreationFailureException(this.failures);

  final List<CreationFailureReason> failures;

  @override
  String toString() => 'CreationFailureException(failures: $failures)';
}

enum CreationFailureReason {
  /// [PkPass.icon] is missing
  missingIconImage,

  /// [PkPass.logo] is missing
  missingLogoImage,

  /// [PkPass.background] is set, but it should not be set
  superfluousBackgroundImage,

  /// [PkPass.thumbnail] is set, but it should not be set
  superfluousThumbnailImage,

  /// When thrown for a PkPass:
  // TODO(any): Describe the problem
  /// When thrown for a PkOrder:
  // TODO(any): Describe the problem
  certificateIdentifierMistmatch,

  /// When thrown for a PkPass:
  // TODO(any): Describe the problem
  /// When thrown for a PkOrder:
  // TODO(any): Describe the problem
  certificateTeamIdentifierMismatch,

  /// Indicates that a language is not completely translated, thus missing one
  /// or more translated strings compared to the other translated languages.
  incompleteTranslation,

  /// One of [PassData.coupon], [PassData.generic], [PassData.eventTicket],
  /// [PassData.storeCard] or [PassData.boardingPass] must be set.
  undefinedPassType,
}
