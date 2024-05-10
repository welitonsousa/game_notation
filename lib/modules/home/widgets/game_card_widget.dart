import 'package:flutter/material.dart';
import 'package:game_notion/core/extensions/string_ext.dart';
import 'package:game_notion/models/game_model.dart';
import 'package:get/get.dart';

class GameCardWidget extends StatelessWidget {
  final GameModel game;
  const GameCardWidget({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [
          Column(
            children: [
              if (game.cover != null)
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Image.network(
                    game.cover!.imageId.imageURL,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 160,
                  ),
                )
              else
                const SizedBox.shrink(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  game.name,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          if (game.state != null)
            Align(
              alignment: Alignment.topRight,
              child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: context.theme.primaryColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(1000),
                    ),
                  ),
                  child: Icon(
                    game.state!.icon,
                    color: Colors.white,
                  )),
            ),
        ],
      ),
    );
  }
}
