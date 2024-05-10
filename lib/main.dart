import 'package:fast_ui_kit/ui/theme/fast_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_notion/core/settings/app_initialize.dart';
import 'package:game_notion/routers/pages.dart';
import 'package:get/get.dart';

Future<void> main() async {
  await AppInitialize.initialize();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  final bool hasUser;
  MyApp({super.key, this.hasUser = false});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final theme = FastTheme(seed: Colors.deepPurpleAccent);

  bool hasUser = false;

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
      title: 'Game Notation',
      darkTheme: theme.dark,
      theme: theme.light,
      initialRoute: widget.hasUser ? AppPages.home : AppPages.signIn,
      getPages: AppPages.pages,
    );
  }
}
