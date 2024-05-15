import 'dart:developer';
import 'package:game_notion/models/enum/game_state_enum.dart';
import 'package:game_notion/models/game_small_model.dart';
import 'package:game_notion/remote/services/games/games_sevice.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final GameService gameService;

  HomeController({required this.gameService});

  final pageGameState = GameState.finished.obs;
  final isSearch = false.obs;
  final localFilter = ''.obs;
  final loading = true.obs;

  final allGames = <GameSmallModel>[].obs;
  List<GameSmallModel> get games {
    var list = allGames.where((g) {
      if (pageGameState.value == GameState.finished &&
          g.state == GameState.platinum) {
        return true;
      }
      return g.state == pageGameState.value;
    });
    list = list.where((g) {
      return g.name.toLowerCase().contains(localFilter.value.toLowerCase());
    });
    list = list.toList()..sort((a, b) => a.name.compareTo(b.name));
    return list.toList();
  }

  Future<List<GameSmallModel>> searchGames({required String q}) async {
    if (q.trim().isEmpty) return [];

    try {
      return await gameService.searchGames(q: q);
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  void openSteamGamesList() {
    final s = gameService.gamesStream();
    s?.listen((g) {
      allGames.assignAll(g);
      loading.value = false;
    });
  }

  @override
  void onReady() {
    openSteamGamesList();
    super.onReady();
  }
}
