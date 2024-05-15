import 'package:game_notion/models/game_model.dart';

import 'cover_model.dart';
import 'enum/game_state_enum.dart';

class GameSmallModel {
  final int id;
  final String name;
  final CoverModel? cover;
  GameState? state;

  GameSmallModel({
    required this.id,
    required this.name,
    required this.cover,
    this.state,
  });

  factory GameSmallModel.fromJson(json) {
    final res = GameSmallModel(
      id: json['id'],
      name: json['name'] ?? '',
      state: GameState.fromId(json['state']),
      cover: json['cover'] != null ? CoverModel.fromJson(json['cover']) : null,
    );

    return res;
  }

  factory GameSmallModel.fromGameModel(GameModel game) {
    return GameSmallModel(
      id: game.id,
      name: game.name,
      cover: game.cover,
      state: game.state,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'cover': cover?.toJson(),
      'state': state?.index,
    };
  }
}
