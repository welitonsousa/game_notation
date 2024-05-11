import 'package:game_notion/models/game_model.dart';

abstract class GameRepository {
  Future<List<GameModel>> searchGames({required String q});
  Future<GameModel> getGameById({required int id});
  Future<void> saveGame({required GameModel game});
  Stream<List<GameModel>>? gamesStream();
  Future<void> removeGame({required int id});
}
