import 'package:fast_ui_kit/ui/theme/fast_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_notion/core/settings/app_initialize.dart';
import 'package:game_notion/routers/pages.dart';
import 'package:get/get.dart';

import 'splash_main.dart';

Future<void> main() async {
  final theme = FastTheme(seed: Colors.deepPurpleAccent);
  runApp(SplashMain(theme: theme));
  await AppInitialize.initialize();
  runApp(MyApp(theme: theme));
}

class MyApp extends StatefulWidget {
  final FastTheme theme;
  const MyApp({super.key, required this.theme});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        Get.offAllNamed(AppPages.home);
      } else {
        Get.offAllNamed(AppPages.signIn);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Game Notion',
      darkTheme: widget.theme.dark,
      theme: widget.theme.light,
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.signIn,
      getPages: AppPages.pages,
    );
  }
}
