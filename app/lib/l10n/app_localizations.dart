import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('de')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Cards'**
  String get appName;

  /// No description provided for @import.
  ///
  /// In en, this message translates to:
  /// **'Import new pass'**
  String get import;

  /// No description provided for @importPass.
  ///
  /// In en, this message translates to:
  /// **'Import this pass'**
  String get importPass;

  /// No description provided for @pickPasses.
  ///
  /// In en, this message translates to:
  /// **'Pick passes'**
  String get pickPasses;

  /// No description provided for @associatediOSApps.
  ///
  /// In en, this message translates to:
  /// **'Associated iOS Apps'**
  String get associatediOSApps;

  /// No description provided for @associatediOSAppsDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Due to limitations of the Pass files, it\'s only possible to show iOS apps.'**
  String get associatediOSAppsDisclaimer;

  /// No description provided for @appDescription.
  ///
  /// In en, this message translates to:
  /// **'Cards is an app which manages your passes. It\'s completely open source and does not track any personal information.'**
  String get appDescription;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'Version: {version}'**
  String appVersion(String version);

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @overrideShareProhibitedFlag.
  ///
  /// In en, this message translates to:
  /// **'Share passes even if they disallow it'**
  String get overrideShareProhibitedFlag;

  /// No description provided for @reportIssue.
  ///
  /// In en, this message translates to:
  /// **'Report a bug'**
  String get reportIssue;

  /// No description provided for @noPassesToShow.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t added any passes yet.'**
  String get noPassesToShow;

  /// No description provided for @updateButton.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get updateButton;

  /// No description provided for @deletePass.
  ///
  /// In en, this message translates to:
  /// **'Delete pass'**
  String get deletePass;

  /// No description provided for @deletePassConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to delete this pass?'**
  String get deletePassConfirmation;

  /// No description provided for @createPass.
  ///
  /// In en, this message translates to:
  /// **'Create Pass'**
  String get createPass;

  /// No description provided for @passType.
  ///
  /// In en, this message translates to:
  /// **'Pass Type'**
  String get passType;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @enterDescription.
  ///
  /// In en, this message translates to:
  /// **'Please enter a description'**
  String get enterDescription;

  /// No description provided for @pickIcon.
  ///
  /// In en, this message translates to:
  /// **'Pick Icon'**
  String get pickIcon;

  /// No description provided for @foregroundColor.
  ///
  /// In en, this message translates to:
  /// **'Foreground Color'**
  String get foregroundColor;

  /// No description provided for @backgroundColor.
  ///
  /// In en, this message translates to:
  /// **'Background Color'**
  String get backgroundColor;

  /// No description provided for @labelColor.
  ///
  /// In en, this message translates to:
  /// **'Label Color'**
  String get labelColor;

  /// No description provided for @headerFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Header Field Label'**
  String get headerFieldLabel;

  /// No description provided for @primaryFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Primary Field Label'**
  String get primaryFieldLabel;

  /// No description provided for @secondaryFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Secondary Field Label'**
  String get secondaryFieldLabel;

  /// No description provided for @auxiliaryFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Auxiliary Field Label'**
  String get auxiliaryFieldLabel;

  /// No description provided for @transitType.
  ///
  /// In en, this message translates to:
  /// **'Transit Type'**
  String get transitType;

  /// No description provided for @passSaved.
  ///
  /// In en, this message translates to:
  /// **'Pass saved!'**
  String get passSaved;

  /// No description provided for @pickAColor.
  ///
  /// In en, this message translates to:
  /// **'Pick a color'**
  String get pickAColor;

  /// No description provided for @selectColor.
  ///
  /// In en, this message translates to:
  /// **'Select color'**
  String get selectColor;

  /// No description provided for @selectColorShade.
  ///
  /// In en, this message translates to:
  /// **'Select color shade'**
  String get selectColorShade;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @pickLogo.
  ///
  /// In en, this message translates to:
  /// **'Pick Logo'**
  String get pickLogo;

  /// No description provided for @pickThumbnail.
  ///
  /// In en, this message translates to:
  /// **'Pick Thumbnail'**
  String get pickThumbnail;

  /// No description provided for @pickStrip.
  ///
  /// In en, this message translates to:
  /// **'Pick Strip'**
  String get pickStrip;

  /// No description provided for @pickBackground.
  ///
  /// In en, this message translates to:
  /// **'Pick Background'**
  String get pickBackground;

  /// No description provided for @pickPassImageTitle.
  ///
  /// In en, this message translates to:
  /// **'Pick Pass Image'**
  String get pickPassImageTitle;

  /// No description provided for @assetType.
  ///
  /// In en, this message translates to:
  /// **'Asset Type'**
  String get assetType;

  /// No description provided for @chooseImage.
  ///
  /// In en, this message translates to:
  /// **'Choose Image'**
  String get chooseImage;

  /// No description provided for @useImage.
  ///
  /// In en, this message translates to:
  /// **'Use Image'**
  String get useImage;

  /// No description provided for @noImageSelected.
  ///
  /// In en, this message translates to:
  /// **'No image selected'**
  String get noImageSelected;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'de'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'de':
      return AppLocalizationsDe();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
