import 'package:flutter/material.dart';
import 'package:game_notion/models/enum/game_state_enum.dart';

class SettingsModel {
  Color themeColor;
  ThemeMode themeMode;
  String fontName;
  List<GameState> gameStates;

  SettingsModel({
    this.themeColor = Colors.deepPurple,
    this.themeMode = ThemeMode.system,
    this.fontName = 'Inter',
    this.gameStates = const [
      GameState.playing,
      GameState.finished,
      GameState.platinum,
      GameState.wishlist,
      GameState.paused,
    ],
  });

  toJson() {
    return {
      'themeColor': themeColor.value,
      'themeMode': themeMode.index,
      'fontName': fontName,
      'gameStates': gameStates.map((e) => e.index).toList(),
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
      gameStates: json['gameStates']
          .map<GameState>((e) => GameState.values[e])
          .toList(),
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
