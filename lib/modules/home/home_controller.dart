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

  final _games = <GameModel>[].obs;
  List<GameModel> get games {
    final list = _games.where((g) => g.state == pageGameState.value);
    return list.where((g) {
      return g.name.toLowerCase().contains(localFilter.value.toLowerCase());
    }).toList();
  }

  Future<List<GameModel>> searchGames({required String q}) async {
    if (q.trim().isEmpty) return [];

    try {
      return await gameService.searchGames(q: q);
    } catch (e) {
      return [];
    }
  }

  void openSteamGamesList() {
    final s = gameService.gamesStream();
    s?.listen((g) {
      _games.assignAll(g);
    });
  }

  Future<void> saveGame(GameModel game) {
    return gameService.saveGame(game: game);
  }

  @override
  void onReady() {
    openSteamGamesList();
    super.onReady();
  }
}
