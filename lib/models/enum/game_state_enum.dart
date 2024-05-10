import 'package:fast_ui_kit/fast_ui_kit.dart';
import 'package:flutter/material.dart';

enum GameState {
  playing,
  finished,
  wishlist,
  platinum,
  paused;

  String get label {
    return switch (this) {
      playing => 'Jogando',
      finished => 'Zerado',
      platinum => 'Platinado',
      wishlist => 'Lista de Desejos',
      paused => 'Parado',
    };
  }

  IconData get icon {
    return switch (this) {
      playing => FastIcons.awesome.gamepad,
      finished => FastIcons.feather.award,
      platinum => FastIcons.awesome.trophy,
      wishlist => FastIcons.awesome.heart,
      paused => FastIcons.awesome.clock_o
    };
  }
}
