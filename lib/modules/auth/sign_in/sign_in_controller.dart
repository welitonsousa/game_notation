import 'package:firebase_auth/firebase_auth.dart';
import 'package:game_notion/core/ui/app_message.dart';
import 'package:game_notion/remote/services/auth/auth_service.dart';
import 'package:game_notion/routers/pages.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final AuthService authService;

  SignInController({required this.authService});
  final loading = false.obs;

  Future<void> signIn({required String email, required String password}) async {
    try {
      loading.value = true;
      await authService.signIn(email: email, password: password);
      Get.offAndToNamed(AppPages.home);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        AppMessage.error("Senha inválida");
      } else if (e.code == 'user-not-found') {
        AppMessage.error("Usuário não cadastrado");
      } else if (e.code == 'too-many-requests') {
        AppMessage.error("Muitas tentativas de login");
      } else {
        AppMessage.error("Não foi possível realizar o login");
      }
    } finally {
      loading.value = false;
    }
  }
}
