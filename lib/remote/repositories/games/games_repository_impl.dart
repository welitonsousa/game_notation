import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:game_notion/core/rest_client/rest_client.dart';
import 'package:game_notion/core/settings/env.dart';
import 'package:game_notion/models/game_model.dart';

import 'games_repository.dart';

class GameRepositoryImpl implements GameRepository {
  final RestClient restClient;
  final FirebaseFirestore storage;
  final FirebaseAuth auth;

  GameRepositoryImpl({
    required this.restClient,
    required this.storage,
    required this.auth,
  });

  @override
  Future<void> saveGame({required GameModel game}) async {
    final uid = auth.currentUser?.uid;
    if (uid == null) return;
    await storage.collection(uid).doc(game.id.toString()).set(game.toJson());
  }

  @override
  Future<void> removeGame({required int id}) async {
    final uid = auth.currentUser?.uid;
    if (uid != null) {
      return storage.collection(uid).doc(id.toString()).delete();
    }
  }

  @override
  Stream<List<GameModel>>? gamesStream() {
    final uid = auth.currentUser?.uid;
    if (uid == null) return null;
    final res = storage.collection(uid).snapshots().map((query) =>
        query.docs.map((doc) => GameModel.fromJson(doc.data())).toList());
    return res;
  }

  @override
  Future<List<GameModel>> searchGames({required String q}) async {
    const fields =
        "cover.image_id,name,summary,screenshots.image_id,similar_games.cover.image_id,similar_games.name,first_release_date,platforms.abbreviation,platforms.name,platforms.slug;";
    await _twitchSignIn();
    final res = await restClient.post(
      '/games/',
      queryParameters: {'search': q, 'fields': fields},
      options: restClient.auth(),
    );

    final list = res.data.map<GameModel>(GameModel.fromJson).toList();

    return list;
  }

  @override
  Future<GameModel> getGameById({required int id}) async {
    final data =
        """where id=$id; fields cover.image_id,name,summary,screenshots.image_id,similar_games.cover.image_id,similar_games.name,first_release_date,platforms.abbreviation,platforms.name,platforms.slug;""";
    await _twitchSignIn();
    final res = await restClient.post(
      '/games/',
      data: data,
      options: restClient.auth(),
    );

    return GameModel.fromJson(res.data[0]);
  }

  Future<String> _twitchSignIn() async {
    if (Env.token.isNotEmpty) return Env.token;

    final res =
        await Dio().post('https://id.twitch.tv/oauth2/token', queryParameters: {
      'client_id': Env.clientID,
      'client_secret': Env.clientSecret,
      'grant_type': 'client_credentials',
    });

    Env.token = res.data['access_token'];
    return Env.token;
  }
}
