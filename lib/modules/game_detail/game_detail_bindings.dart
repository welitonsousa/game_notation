import 'package:get/get.dart';
import './game_detail_controller.dart';

class GameDetailBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(GameDetailController(
      gameService: Get.find(),
      homeController: Get.find(),
    ));
  }
}
