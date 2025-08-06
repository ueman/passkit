// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Cards';

  @override
  String get import => 'Import new pass';

  @override
  String get importPass => 'Import this pass';

  @override
  String get pickPasses => 'Pick passes';

  @override
  String get associatediOSApps => 'Associated iOS Apps';

  @override
  String get associatediOSAppsDisclaimer =>
      'Due to limitations of the Pass files, it\'s only possible to show iOS apps.';

  @override
  String get appDescription =>
      'Cards is an app which manages your passes. It\'s completely open source and does not track any personal information.';

  @override
  String appVersion(String version) {
    return 'Version: $version';
  }

  @override
  String get settings => 'Settings';

  @override
  String get overrideShareProhibitedFlag =>
      'Share passes even if they disallow it';

  @override
  String get reportIssue => 'Report a bug';

  @override
  String get noPassesToShow => 'You haven\'t added any passes yet.';

  @override
  String get updateButton => 'Update';

  @override
  String get deletePass => 'Delete pass';

  @override
  String get deletePassConfirmation =>
      'Do you really want to delete this pass?';
}
