import 'package:fast_ui_kit/icons/icons.dart';
import 'package:fast_ui_kit/ui/widgets/animate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:game_notion/core/extensions/string_ext.dart';
import 'package:game_notion/models/game_model.dart';
import 'package:game_notion/modules/home/home_controller.dart';
import 'package:game_notion/routers/pages.dart';
import 'package:get/get.dart';

class SearchGamesWidget extends StatefulWidget {
  const SearchGamesWidget({super.key});

  @override
  State<SearchGamesWidget> createState() => _SearchGamesWidgetState();
}

class _SearchGamesWidgetState extends State<SearchGamesWidget> {
  final controller = Get.find<HomeController>();
  final searController = TextEditingController();
  final focus = FocusNode();

  @override
  void dispose() {
    focus.dispose();
    searController.dispose();
    super.dispose();
  }

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
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
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
                  onSelected: (game) async {
                    focus.unfocus();
                    await Get.toNamed(
                      "${AppPages.gameDetail}/${game.id}",
                      arguments: game.id,
                      preventDuplicates: false,
                    );
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
                          filled: true,
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
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
              label: const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(' Game'),
              ),
              icon: Icon(FastIcons.awesome.gamepad),
            )
        ],
      ),
    );
  }
}
