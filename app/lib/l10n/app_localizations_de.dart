// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appName => 'Cards';

  @override
  String get import => 'Importiere eine neue Pass-Datei';

  @override
  String get importPass => 'Importieren';

  @override
  String get pickPasses => 'Wähle einen Pass';

  @override
  String get associatediOSApps => 'Zugehörige iOS-Apps';

  @override
  String get associatediOSAppsDisclaimer =>
      'Aufgrund von Einschränkungen der Pass-Dateien ist es nur möglich, iOS-Apps anzuzeigen.';

  @override
  String get appDescription =>
      'Cards ist eine App, die deine Pässe verwaltet. Sie ist vollständig Open Source und verfolgt keine persönlichen Informationen.';

  @override
  String appVersion(String version) {
    return 'Version: $version';
  }

  @override
  String get settings => 'Einstellungen';

  @override
  String get overrideShareProhibitedFlag =>
      'Pässe teilen, auch wenn sie es verbieten';

  @override
  String get reportIssue => 'Fehler melden';

  @override
  String get noPassesToShow => 'Du hast noch keine Pässe hinzugefügt.';

  @override
  String get updateButton => 'Aktualisieren';

  @override
  String get deletePass => 'Pass löschen';

  @override
  String get deletePassConfirmation =>
      'Möchtest du diesen Pass wirklich löschen?';

  @override
  String get createPass => 'Pass erstellen';

  @override
  String get passType => 'Pass-Typ';

  @override
  String get description => 'Beschreibung';

  @override
  String get enterDescription => 'Bitte gib eine Beschreibung ein';

  @override
  String get pickIcon => 'Icon auswählen';

  @override
  String get foregroundColor => 'Vordergrundfarbe';

  @override
  String get backgroundColor => 'Hintergrundfarbe';

  @override
  String get labelColor => 'Label-Farbe';

  @override
  String get headerFieldLabel => 'Header-Feld-Label';

  @override
  String get primaryFieldLabel => 'Primärfeld-Label';

  @override
  String get secondaryFieldLabel => 'Sekundärfeld-Label';

  @override
  String get auxiliaryFieldLabel => 'Hilfsfeld-Label';

  @override
  String get transitType => 'Transit-Typ';

  @override
  String get passSaved => 'Pass gespeichert!';

  @override
  String get pickAColor => 'Wähle eine Farbe';

  @override
  String get selectColor => 'Farbe auswählen';

  @override
  String get selectColorShade => 'Farbton auswählen';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get ok => 'OK';

  @override
  String get pickLogo => 'Logo auswählen';

  @override
  String get pickThumbnail => 'Thumbnail auswählen';

  @override
  String get pickStrip => 'Streifen auswählen';

  @override
  String get pickBackground => 'Hintergrund auswählen';

  @override
  String get pickPassImageTitle => 'Pass-Bild wählen';

  @override
  String get assetType => 'Asset-Typ';

  @override
  String get chooseImage => 'Bild auswählen';

  @override
  String get useImage => 'Bild verwenden';

  @override
  String get noImageSelected => 'Kein Bild ausgewählt';
}
