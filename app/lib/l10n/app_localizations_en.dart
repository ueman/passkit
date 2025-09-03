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

  @override
  String get createPass => 'Create Pass';

  @override
  String get passType => 'Pass Type';

  @override
  String get description => 'Description';

  @override
  String get enterDescription => 'Please enter a description';

  @override
  String get pickIcon => 'Pick Icon';

  @override
  String get foregroundColor => 'Foreground Color';

  @override
  String get backgroundColor => 'Background Color';

  @override
  String get labelColor => 'Label Color';

  @override
  String get headerFieldLabel => 'Header Field Label';

  @override
  String get primaryFieldLabel => 'Primary Field Label';

  @override
  String get secondaryFieldLabel => 'Secondary Field Label';

  @override
  String get auxiliaryFieldLabel => 'Auxiliary Field Label';

  @override
  String get transitType => 'Transit Type';

  @override
  String get passSaved => 'Pass saved!';

  @override
  String get pickAColor => 'Pick a color';

  @override
  String get selectColor => 'Select color';

  @override
  String get selectColorShade => 'Select color shade';

  @override
  String get cancel => 'Cancel';

  @override
  String get ok => 'OK';

  @override
  String get pickLogo => 'Pick Logo';

  @override
  String get pickThumbnail => 'Pick Thumbnail';

  @override
  String get pickStrip => 'Pick Strip';

  @override
  String get pickBackground => 'Pick Background';

  @override
  String get pickPassImageTitle => 'Pick Pass Image';

  @override
  String get assetType => 'Asset Type';

  @override
  String get chooseImage => 'Choose Image';

  @override
  String get useImage => 'Use Image';

  @override
  String get noImageSelected => 'No image selected';
}
