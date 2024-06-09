import 'package:flutter/material.dart';

class SettingsModel {
  Color themeColor;
  ThemeMode themeMode;
  String fontName;
  SettingsModel({
    this.themeColor = Colors.deepPurple,
    this.themeMode = ThemeMode.system,
    this.fontName = 'Inter',
  });

  toJson() {
    return {
      'themeColor': themeColor.value,
      'themeMode': themeMode.index,
      'fontName': fontName,
    };
  }

  static List<String> get fonts => [
        'Inter',
        'Comfortaa',
        'Roboto',
        'Oswald',
        'Lato',
        'Ubuntu',
      ];

  static SettingsModel fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      themeColor: Color(json['themeColor']),
      themeMode: ThemeMode.values[json['themeMode']],
      fontName: json['fontName'],
    );
  }

  static List<Color> get colors => [
        Colors.deepPurple,
        Colors.blue,
        Colors.red,
        Colors.green,
        Colors.orange,
        Colors.pink,
        Colors.purple,
        Colors.teal,
        Colors.amber,
        Colors.cyan,
        Colors.indigo,
        Colors.lime,
        Colors.brown,
        Colors.grey,
        Colors.blueGrey,
      ];
}
