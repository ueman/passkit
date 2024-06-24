import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  factory AppPreferences() => _singleton;

  AppPreferences._internal();

  static final AppPreferences _singleton = AppPreferences._internal();
  late SharedPreferences _preferences;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  bool get overrideShareProhibitedFlag =>
      _preferences.getBool('override_share_prohibited_flag') ?? false;

  set overrideShareProhibitedFlag(bool value) {
    _preferences.setBool('override_share_prohibited_flag', value);
  }
}
