import 'package:fast_ui_kit/fast_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:game_notion/core/settings/user_settings_controller.dart';
import 'package:game_notion/models/enum/game_state_enum.dart';

class GameStateWidget extends StatelessWidget {
  final Function(GameState) onChange;
  final GameState state;
  const GameStateWidget({
    super.key,
    required this.onChange,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return FastAnimate(
      type: FastAnimateType.elasticInDown,
      duration: const Duration(seconds: 1),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: FastButtonGroup<GameState>(
          callback: (v) {
            if (v.isNotEmpty) onChange(v.first);
          },
          allowEmpty: false,
          multiple: false,
          values: UserSettingsController.instance.settings.gameStates,
          initial: [state],
        ),
      ),
    );
  }
}
