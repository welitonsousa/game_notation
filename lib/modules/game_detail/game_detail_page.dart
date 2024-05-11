import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:fast_ui_kit/icons/icons.dart';
import 'package:game_notion/core/extensions/string_ext.dart';
import 'package:game_notion/core/ui/widgets/app_error.dart';
import 'package:game_notion/core/ui/widgets/app_image.dart';
import 'package:game_notion/core/ui/widgets/app_loading.dart';
import 'package:game_notion/modules/game_detail/widgets/game_state_widget.dart';
import 'package:game_notion/modules/game_detail/widgets/list_similar_games.dart';
import 'package:game_notion/modules/game_detail/widgets/screenshots_grid.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './game_detail_controller.dart';

class GameDetailPage extends GetView<GameDetailController> {
  const GameDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              if (controller.loading.value)
                const AppLoading()
              else if (controller.error.value)
                AppError(onRetry: controller.findGame)
              else if (controller.game.value != null)
                Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 1280),
                    child: ListView(
                      children: [
                        if (controller.game.value!.cover != null)
                          Container(
                            height: 300,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                showImageViewer(
                                  context,
                                  AppImageCached.provider(controller
                                      .game.value!.cover!.imageId.imageURL),
                                  useSafeArea: true,
                                  swipeDismissible: true,
                                  immersive: true,
                                );
                              },
                              child: AppImageCached(
                                path: controller
                                    .game.value!.cover!.imageId.imageURL,
                                fit: BoxFit.fitHeight,
                                width: double.infinity,
                              ),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(controller.game.value!.name,
                              style: const TextStyle(fontSize: 24)),
                        ),
                        GameStateWidget(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            controller.game.value!.summary,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Jogos similares',
                                style: TextStyle(fontSize: 22),
                              ),
                              const SizedBox(height: 20),
                              ListSimilarGames(
                                similarGames:
                                    controller.game.value!.similarGames,
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Capturas de tela',
                                style: TextStyle(fontSize: 22),
                              ),
                              const SizedBox(height: 20),
                              ScreenshotsGridView(
                                screenshots: controller.game.value!.screenshots
                                    .map((e) => e.imageId.imageURL)
                                    .toList(),
                              ),
                              const SizedBox(height: 40),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              if (controller.game.value != null)
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: controller.toggleFavorite,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: context.theme.scaffoldBackgroundColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(200)),
                      ),
                      child: Icon(
                        FastIcons.awesome.heart,
                        color: controller.gameState != null
                            ? context.theme.primaryColor
                            : null,
                      ),
                    ),
                  ),
                ),
              Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: context.theme.scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.all(Radius.circular(200)),
                ),
                child: const CloseButton(),
              ),
            ],
          ),
        ),
      );
    });
  }
}
