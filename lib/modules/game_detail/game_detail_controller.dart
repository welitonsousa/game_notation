import 'package:game_notion/models/game_model.dart';
import 'package:game_notion/modules/home/home_controller.dart';
import 'package:game_notion/remote/services/games/games_sevice.dart';
import 'package:get/get.dart';

class GameDetailController extends GetxController {
  final GameService gameService;
  final HomeController homeController;
  GameDetailController({
    required this.gameService,
    required this.homeController,
  });

  late final int gameId;
  late final GameModel game;
  final loading = true.obs;
  final error = false.obs;

  Future<void> findGame() async {
    try {
      loading.value = true;
      game = await gameService.getGameById(id: gameId);
    } catch (e) {
      error.value = true;
    } finally {
      loading.value = false;
    }
  }

  @override
  void onInit() {
    gameId = int.parse(Get.parameters['id']!);

    findGame();
    super.onInit();
  }
}
