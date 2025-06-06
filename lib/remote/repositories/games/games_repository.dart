import 'package:game_notion/models/game_model.dart';
import 'package:game_notion/models/game_small_model.dart';

abstract class GameRepository {
  Future<List<GameSmallModel>> searchGames({required String q});
  Future<GameModel> getGameById({required int id});
  Future<void> saveGame({required GameSmallModel game});
  Stream<List<GameSmallModel?>>? gamesStream();
  Future<void> removeGame({required int id});
}
