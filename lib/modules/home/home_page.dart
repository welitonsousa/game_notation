import 'package:fast_ui_kit/icons/icons.dart';
import 'package:fast_ui_kit/ui/widgets/animate.dart';
import 'package:fast_ui_kit/ui/widgets/search_app_bar.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:game_notion/core/extensions/string_ext.dart';
import 'package:game_notion/core/ui/app_state.dart';
import 'package:game_notion/models/enum/game_state_enum.dart';
import 'package:game_notion/models/game_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends AppState<HomePage, HomeController> {
  final searController = TextEditingController();
  final focus = FocusNode();

  @override
  void initState() {
    focus.addListener(() {
      if (!focus.hasFocus) {
        controller.isSearch.value = false;
        searController.clear();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    searController.dispose();
    focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: FastSearchAppBar(
          title: 'Game Notion',
          onSearch: controller.localFilter,
        ),
        body: Container(),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (controller.isSearch.value)
              FastAnimate(
                type: FastAnimateType.elasticInRight,
                duration: const Duration(milliseconds: 1000),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: TypeAheadField<GameModel>(
                    focusNode: focus,
                    controller: searController,
                    onSelected: (suggestion) {
                      focus.unfocus();
                    },
                    autoFlipDirection: true,
                    hideOnEmpty: true,
                    builder: (context, controller, child) {
                      return TextFormField(
                        controller: searController,
                        focusNode: focus,
                        autofocus: true,
                        decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                                onTap: focus.unfocus,
                                child: Icon(FastIcons.awesome.close)),
                            hintText: 'Pesquisar',
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            )),
                      );
                    },
                    suggestionsCallback: (v) async {
                      final res = await controller.searchGames(q: v);
                      return res;
                    },
                    itemBuilder: (context, suggestion) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(suggestion.name),
                          leading: SizedBox(
                            child: Column(
                              children: [
                                if (suggestion.cover?.imageId != null)
                                  SizedBox(
                                    height: 48,
                                    width: 50,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        suggestion.cover!.imageId.imageURL,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                else
                                  SizedBox(
                                    height: 48,
                                    width: 50,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Icon(FastIcons.awesome.gamepad),
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            else
              ElevatedButton.icon(
                onPressed: () {
                  controller.isSearch.value = !controller.isSearch.value;
                },
                label: const Text('Game'),
                icon: Icon(FastIcons.awesome.gamepad),
              )
          ],
        ),
        bottomNavigationBar: SnakeNavigationBar.color(
          currentIndex: controller.pageGameState.value.index,
          showUnselectedLabels: context.isTablet,
          showSelectedLabels: true,
          snakeViewColor: context.theme.primaryColor,
          unselectedItemColor: context.theme.primaryColor,
          snakeShape: SnakeShape.rectangle,
          onTap: (index) {
            controller.pageGameState.value = GameState.values[index];
          },
          items: GameState.values.map((e) {
            return BottomNavigationBarItem(
              icon: Icon(e.icon),
              label: e.label,
            );
          }).toList(),
        ),
      );
    });
  }
}
