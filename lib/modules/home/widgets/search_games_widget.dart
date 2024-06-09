import 'package:fast_ui_kit/icons/icons.dart';
import 'package:fast_ui_kit/ui/widgets/animate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:game_notion/core/extensions/string_ext.dart';
import 'package:game_notion/models/game_small_model.dart';
import 'package:game_notion/modules/home/home_controller.dart';
import 'package:game_notion/routers/pages.dart';
import 'package:get/get.dart';

class SearchGamesWidget extends StatefulWidget {
  const SearchGamesWidget({super.key});

  @override
  State<SearchGamesWidget> createState() => _SearchGamesWidgetState();
}

class _SearchGamesWidgetState extends State<SearchGamesWidget> {
  final searController = TextEditingController();
  final controller = Get.find<HomeController>();
  final focus = FocusNode();
  final isSearch = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    focus.addListener(listener);
  }

  @override
  void dispose() {
    searController.dispose();
    focus.removeListener(listener);
    focus.dispose();
    isSearch.dispose();
    super.dispose();
  }

  void listener() {
    if (!focus.hasFocus) {
      isSearch.value = false;
      searController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: isSearch,
      builder: (context, value) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isSearch.value)
            FastAnimate(
              type: FastAnimateType.elasticInRight,
              duration: const Duration(milliseconds: 1000),
              child: Padding(
                padding: const EdgeInsets.only(left: 30),
                child: TypeAheadField<GameSmallModel>(
                  focusNode: focus,
                  controller: searController,
                  onSelected: (game) async {
                    focus.unfocus();
                    isSearch.value = false;
                    await Get.toNamed(
                      '${AppPages.gameDetail}/${game.id}',
                      arguments: game.id,
                      preventDuplicates: false,
                    );
                  },
                  autoFlipDirection: true,
                  hideOnEmpty: true,
                  builder: (context, controller, child) {
                    return TextFormField(
                      controller: controller,
                      focusNode: focus,
                      autofocus: true,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                            onTap: () {
                              isSearch.value = false;
                              searController.clear();
                              focus.unfocus();
                            },
                            child: Icon(FastIcons.awesome.close)),
                        hintText: 'Pesquisar',
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
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
                                      suggestion.cover!.imageId.imageThumbURL,
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
              style: ElevatedButton.styleFrom(
                elevation: 2,
              ),
              onPressed: () {
                isSearch.value = !isSearch.value;
                if (isSearch.value) focus.requestFocus();
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
