import 'package:fast_ui_kit/ui/theme/fast_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_notion/core/settings/app_initialize.dart';
import 'package:game_notion/routers/pages.dart';
import 'package:get/get.dart';

Future<void> main() async {
  await AppInitialize.initialize();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final theme = FastTheme(seed: Colors.deepPurpleAccent);

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
      darkTheme: theme.dark,
      theme: theme.light,
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.signIn,
      getPages: AppPages.pages,
    );
  }
}
