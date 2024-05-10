import 'package:game_notion/models/enum/game_state_enum.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final pageGameState = GameState.finished.obs;
}
