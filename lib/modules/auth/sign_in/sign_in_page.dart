import 'package:fast_ui_kit/ui/widgets/button.dart';
import 'package:fast_ui_kit/ui/widgets/form_field.dart';
import 'package:game_notion/core/ui/app_state.dart';
import 'package:game_notion/routers/pages.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './sign_in_controller.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends AppState<SignInPage, SignInController> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final form = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: ListView(
        children: [
          Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: context.theme.cardColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Form(
                key: form,
                child: Column(
                  children: [
                    FastFormField(
                      label: 'E-mail',
                      validator: Zod().email().build,
                      controller: emailController,
                      textInputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 10),
                    FastFormField(
                      label: 'Senha',
                      validator: Zod().min(6).build,
                      controller: passwordController,
                      isPassword: true,
                      textInputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 10),
                    Obx(() {
                      return FastButton(
                        label: 'Entrar',
                        loading: controller.loading.value,
                        onPressed: () {
                          if (form.currentState!.validate()) {
                            controller.signIn(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                      );
                    }),
                    TextButton(
                      onPressed: () => Get.toNamed(AppPages.signUp),
                      child: const Text('Cadastrar'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
