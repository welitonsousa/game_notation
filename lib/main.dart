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

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final theme = FastTheme(seed: Colors.deepPurpleAccent);
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Game Notation',
      darkTheme: theme.dark,
      theme: theme.light,
      initialRoute: user != null ? AppPages.home : AppPages.signIn,
      getPages: AppPages.pages,
    );
  }
}
