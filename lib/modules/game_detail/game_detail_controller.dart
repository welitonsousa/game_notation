import 'package:game_notion/models/enum/game_state_enum.dart';
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
  final game = Rxn<GameModel>();

  GameState? get gameState {
    final index =
        homeController.allGames.indexWhere((e) => e.id == game.value?.id);
    if (index == -1) return null;
    return homeController.allGames[index].state;
  }

  final loading = true.obs;
  final error = false.obs;

  Future<void> findGame() async {
    try {
      loading.value = true;
      game.value = await gameService.getGameById(id: gameId);
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

  void toggleFavorite() {
    if (game.value == null) return;
    if (game.value!.state != null) {
      game.value!.state = null;
      gameService.removeGame(id: game.value!.id);
    } else {
      game.value!.state = GameState.wishlist;
      gameService.saveGame(game: game.value!);
    }
    game.refresh();
  }

  void changeGameState(GameState state) {
    if (game.value == null) return;

    game.value!.state = state;
    gameService.saveGame(game: game.value!);
  }
}
