import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:fast_ui_kit/icons/icons.dart';
import 'package:game_notion/core/extensions/string_ext.dart';
import 'package:game_notion/core/ui/widgets/app_error.dart';
import 'package:game_notion/core/ui/widgets/app_image.dart';
import 'package:game_notion/core/ui/widgets/app_loading.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './game_detail_controller.dart';

class GameDetailPage extends GetView<GameDetailController> {
  const GameDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              if (controller.loading.value)
                const AppLoading()
              else if (controller.error.value)
                AppError(onRetry: controller.findGame)
              else
                Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 1280),
                    child: ListView(
                      children: [
                        if (controller.game.cover != null)
                          Container(
                            constraints: const BoxConstraints(maxHeight: 300),
                            decoration: const BoxDecoration(
                              color: Colors.black,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                showImageViewer(
                                  context,
                                  AppImageCached.provider(
                                      controller.game.cover!.imageId.imageURL),
                                  useSafeArea: true,
                                  swipeDismissible: true,
                                  immersive: true,
                                );
                              },
                              child: AppImageCached(
                                path: controller.game.cover!.imageId.imageURL,
                                fit: BoxFit.fitHeight,
                                width: double.infinity,
                              ),
                            ),
                          )
                        else
                          const SizedBox.shrink(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(controller.game.name,
                              style: const TextStyle(fontSize: 24)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            controller.game.summary,
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
                              SizedBox(
                                height: 230,
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    final g =
                                        controller.game.similarGames[index];
                                    return GestureDetector(
                                      onTap: () async {},
                                      child: Container(
                                        margin: const EdgeInsets.only(right: 8),
                                        width: 200,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            if (g.cover != null)
                                              Image.network(
                                                g.cover?.imageId.imageURL ?? '',
                                                fit: BoxFit.cover,
                                                height: 200,
                                              ),
                                            const SizedBox(height: 4),
                                            Text(
                                              g.name,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount:
                                      controller.game.similarGames.length,
                                  scrollDirection: Axis.horizontal,
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Capturas de tela',
                                style: TextStyle(fontSize: 22),
                              ),
                              const SizedBox(height: 20),
                              GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 240,
                                  mainAxisExtent: 240,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                ),
                                itemBuilder: (context, index) {
                                  final screenshot =
                                      controller.game.screenshots[index];
                                  return GestureDetector(
                                    onTap: () {
                                      final images = controller.game.screenshots
                                          .map((e) => e.imageId.imageURL)
                                          .toList();
                                      final providers = MultiImageProvider(
                                        initialIndex: index,
                                        images.map((e) {
                                          return AppImageCached.provider(e);
                                        }).toList(),
                                      );

                                      showImageViewerPager(
                                        context,
                                        providers,
                                        infinitelyScrollable: true,
                                        useSafeArea: true,
                                        swipeDismissible: true,
                                        immersive: true,
                                      );
                                    },
                                    child: AppImageCached(
                                      path: screenshot.imageId.imageURL,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                                itemCount: controller.game.screenshots.length,
                              ),
                              const SizedBox(height: 40),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              if (!controller.loading.value && !controller.error.value)
                Align(
                  alignment: Alignment.topRight,
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
                      color: controller.game.state != null
                          ? context.theme.primaryColor
                          : null,
                    ),
                  ),
                ),
              Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: context.theme.scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.all(Radius.circular(200)),
                  ),
                  child: const CloseButton()),
            ],
          ),
        ),
      ),
    );
  }
}
