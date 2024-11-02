import 'package:flutter/material.dart';
import 'package:game_notion/models/enum/game_state_enum.dart';
import 'package:game_notion/models/settings_model.dart';
import 'package:get_storage/get_storage.dart';

class UserSettingsController extends ChangeNotifier {
  static UserSettingsController? _instance;
  UserSettingsController._();
  static UserSettingsController get instance =>
      _instance ??= UserSettingsController._();

  var settings = SettingsModel();

  static SettingsModel initialize() {
    final res = GetStorage().read('settings');
    if (res != null) {
      instance.settings = SettingsModel.fromJson(res);
    }
    return instance.settings;
  }

  void save() {
    GetStorage().write('settings', settings.toJson());
    notifyListeners();
  }

  void changeThemeColor(Color color) {
    settings.themeColor = color;
    save();
  }

  void changeGemeStates(List<GameState> states) {
    settings.gameStates = states;
    save();
  }

  void changeThemeMode(ThemeMode mode) {
    settings.themeMode = mode;
    save();
  }

  void changeFont(String font) {
    settings.fontName = font;
    save();
  }
}
