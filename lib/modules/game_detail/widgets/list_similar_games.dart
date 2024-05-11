import 'package:flutter/material.dart';
import 'package:game_notion/core/extensions/string_ext.dart';
import 'package:game_notion/models/game_external_model.dart';
import 'package:game_notion/routers/pages.dart';
import 'package:get/get.dart';

class ListSimilarGames extends StatelessWidget {
  final List<ExternalGameModel> similarGames;
  const ListSimilarGames({super.key, required this.similarGames});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: ListView.builder(
        itemBuilder: (context, index) {
          final g = similarGames[index];
          return GestureDetector(
            onTap: () async {
              await Get.toNamed(
                "${AppPages.gameDetail}/${g.id}",
                arguments: g.id,
                preventDuplicates: false,
              );
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (g.cover != null)
                    Image.network(
                      g.cover?.imageId.imageURL ?? '',
                      fit: BoxFit.cover,
                      height: 200,
                    ),
                  const SizedBox(height: 4),
                  Text(
                    g.name,
                    style: const TextStyle(
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: similarGames.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
