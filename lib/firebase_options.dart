// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBv6rnnAr5VYe1kaQ_T0-3WSnHKM-nNJLg',
    appId: '1:682329935211:android:ae2a99770b0233bf3f102e',
    messagingSenderId: '682329935211',
    projectId: 'game-notion',
    storageBucket: 'game-notion.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD3mVyBylLiesZJzeR82QXBQ7Kr2vbJ7D0',
    appId: '1:682329935211:ios:d17ff34e29c318653f102e',
    messagingSenderId: '682329935211',
    projectId: 'game-notion',
    storageBucket: 'game-notion.appspot.com',
    iosBundleId: 'com.gamenotion.br.gameNotion',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD3mVyBylLiesZJzeR82QXBQ7Kr2vbJ7D0',
    appId: '1:682329935211:ios:d17ff34e29c318653f102e',
    messagingSenderId: '682329935211',
    projectId: 'game-notion',
    storageBucket: 'game-notion.appspot.com',
    iosBundleId: 'com.gamenotion.br.gameNotion',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB4uMTUZ5H6dCImKJQc8mmrlu6KDaisP78',
    appId: '1:682329935211:web:ee83a71c3bd40d1a3f102e',
    messagingSenderId: '682329935211',
    projectId: 'game-notion',
    authDomain: 'game-notion.firebaseapp.com',
    storageBucket: 'game-notion.appspot.com',
  );
}
