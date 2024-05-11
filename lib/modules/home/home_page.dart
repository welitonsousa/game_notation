import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:game_notion/core/ui/app_state.dart';
import 'package:game_notion/core/ui/dialogs/logout_dialog.dart';
import 'package:game_notion/core/ui/widgets/app_app_bar.dart';
import 'package:game_notion/core/ui/widgets/app_empty.dart';
import 'package:game_notion/models/enum/game_state_enum.dart';
import 'package:game_notion/modules/home/widgets/game_card_widget.dart';
import 'package:game_notion/modules/home/widgets/search_games_widget.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends AppState<HomePage, HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppAppBar(
          title: controller.pageGameState.value.label,
          onSearch: controller.localFilter,
          hint: 'Pesquisar jogos salvos',
          leading: IconButton(
            onPressed: () {
              Get.dialog(const LogoutDialog());
            },
            color: Colors.red,
            tooltip: 'Sair',
            icon: const Icon(Icons.exit_to_app),
          ),
        ),
        body: Visibility(
          visible: controller.games.isNotEmpty,
          replacement: const AppEmpty(),
          child: GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 240,
              mainAxisExtent: 240,
            ),
            itemCount: controller.games.length,
            itemBuilder: (context, index) {
              final game = controller.games[index];
              return GameCardWidget(game: game);
            },
          ),
        ),
        floatingActionButton: const SearchGamesWidget(),
        bottomNavigationBar: SnakeNavigationBar.color(
          currentIndex: controller.pageGameState.value.index,
          showUnselectedLabels: context.isTablet,
          showSelectedLabels: context.isTablet,
          snakeViewColor: context.theme.buttonTheme.colorScheme?.primary,
          unselectedItemColor: context.theme.buttonTheme.colorScheme?.primary,
          snakeShape: SnakeShape.rectangle,
          onTap: (index) {
            controller.pageGameState.value = GameState.values[index];
          },
          items: GameState.values.map((e) {
            return BottomNavigationBarItem(
              icon: Icon(e.icon),
              label: e.label,
              tooltip: e.label,
            );
          }).toList(),
        ),
      );
    });
  }
}
