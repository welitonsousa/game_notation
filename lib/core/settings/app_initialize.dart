import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:game_notion/firebase_options.dart';

class AppInitialize {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Future.wait([
      Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    ]);
  }
}
