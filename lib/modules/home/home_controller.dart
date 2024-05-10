import 'package:game_notion/models/enum/game_state_enum.dart';
import 'package:game_notion/models/game_model.dart';
import 'package:game_notion/remote/services/games/games_sevice.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final GameService gameService;

  HomeController({required this.gameService});

  final pageGameState = GameState.finished.obs;
  final isSearch = false.obs;
  final localFilter = ''.obs;

  Future<List<GameModel>> searchGames({required String q}) async {
    if (q.trim().isEmpty) return [];

    try {
      return await gameService.searchGames(q: q);
    } catch (e) {
      return [];
    }
  }
}
