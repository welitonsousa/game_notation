import 'package:game_notion/models/cover_model.dart';
import 'package:game_notion/models/enum/game_state_enum.dart';
import 'package:game_notion/models/game_external_model.dart';
import 'package:game_notion/models/platform_model.dart';

class GameModel {
  final int id;
  final CoverModel? cover;
  final List<ExternalGameModel> similarGames;
  final String name;
  final List<PlatformModel> platforms;
  final List<CoverModel> screenshots;
  final String summary;
  GameState? state;

  GameModel({
    required this.id,
    required this.similarGames,
    required this.name,
    required this.platforms,
    required this.screenshots,
    required this.summary,
    this.cover,
    this.state,
  });

  factory GameModel.fromJson(json) {
    final res = GameModel(
      id: json['id'],
      state: GameState.fromId(json['state']),
      cover: json['cover'] != null ? CoverModel.fromJson(json['cover']) : null,
      similarGames: (json['similar_games'] ?? [])
          .map<ExternalGameModel>(ExternalGameModel.fromJson)
          .toList(),
      name: json['name'] ?? '',
      platforms: (json['platforms'] ?? [])
          .map<PlatformModel>(PlatformModel.fromJson)
          .toList(),
      screenshots: (json['screenshots'] ?? [])
          .map<CoverModel>(CoverModel.fromJson)
          .toList(),
      summary: json['summary'] ?? '',
    );

    return res;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cover': cover?.toJson(),
      'similar_games': similarGames.map((e) => e.toJson()).toList(),
      'name': name,
      'platforms': platforms.map((e) => e.toJson()).toList(),
      'screenshots': screenshots.map((e) => e.toJson()).toList(),
      'summary': summary,
      'state': state?.index,
    };
  }
}
