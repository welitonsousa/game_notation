import 'package:fast_ui_kit/fast_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:game_notion/models/enum/game_state_enum.dart';
import 'package:game_notion/modules/game_detail/game_detail_controller.dart';
import 'package:get/get.dart';

class GameStateWidget extends StatelessWidget {
  GameStateWidget({super.key});
  final controller = Get.find<GameDetailController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.gameState == null) return const SizedBox();
      final state = controller.gameState;
      return Container(
        padding: const EdgeInsets.all(8),
        child: FastButtonGroup<GameState>(
          callback: (v) {
            if (v.isNotEmpty) controller.changeGameState(v.first);
          },
          allowEmpty: false,
          multiple: false,
          values: GameState.values,
          initial: [state!],
        ),
      );
    });
  }
}
