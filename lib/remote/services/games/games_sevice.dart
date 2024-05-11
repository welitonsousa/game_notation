import 'package:game_notion/models/game_model.dart';

abstract class GameService {
  Future<List<GameModel>> searchGames({required String q});
  Future<GameModel> getGameById({required int id});
  Future<void> saveGame({required GameModel game});
  Future<void> removeGame({required int id});
  Stream<List<GameModel>>? gamesStream();
}
