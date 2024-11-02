import 'package:fast_ui_kit/ui/theme/fast_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_notion/core/settings/app_initialize.dart';
import 'package:game_notion/core/settings/user_settings_controller.dart';
import 'package:game_notion/routers/pages.dart';
import 'package:get/get.dart';

import 'splash_main.dart';

Future<void> main() async {
  var theme = FastTheme(seed: Colors.deepPurpleAccent);
  runApp(SplashMain(theme: theme));
  await AppInitialize.initialize();
  UserSettingsController.initialize();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final settings = UserSettingsController.instance;

  @override
  void initState() {
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        if (Get.currentRoute == AppPages.signIn) {
          Get.offAllNamed(AppPages.home);
        }
      } else {
        Get.offAllNamed(AppPages.signIn);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: UserSettingsController.instance,
        builder: (context, child) {
          final theme = FastTheme(
            seed: settings.settings.themeColor,
            font: settings.settings.fontName,
          );
          return GetMaterialApp(
            title: 'Game Notion',
            darkTheme: theme.dark,
            theme: theme.light,
            themeMode: settings.settings.themeMode,
            debugShowCheckedModeBanner: false,
            initialRoute: AppPages.signIn,
            getPages: AppPages.pages,
          );
        });
  }
}
