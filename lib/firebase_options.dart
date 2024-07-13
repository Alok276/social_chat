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
      return web;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB7NGLF8a8uYryzFA0xTu6AJBIlOSkF4DI',
    appId: '1:880576531628:web:2b0bbf8f7638530e676309',
    messagingSenderId: '880576531628',
    projectId: 'socialchat-bba39',
    authDomain: 'socialchat-bba39.firebaseapp.com',
    storageBucket: 'socialchat-bba39.appspot.com',
    measurementId: 'G-CYP7GRGSD8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBQOcmTWnxmftYh-4zdH8EovP-819Sm4Gg',
    appId: '1:880576531628:android:e23eea3cd1c3762b676309',
    messagingSenderId: '880576531628',
    projectId: 'socialchat-bba39',
    storageBucket: 'socialchat-bba39.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAAMtZhZlcquvBsDcoN9jdDZDAaN3bxTbE',
    appId: '1:880576531628:ios:93ac6561f322e22a676309',
    messagingSenderId: '880576531628',
    projectId: 'socialchat-bba39',
    storageBucket: 'socialchat-bba39.appspot.com',
    iosBundleId: 'com.example.socialChat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAAMtZhZlcquvBsDcoN9jdDZDAaN3bxTbE',
    appId: '1:880576531628:ios:93ac6561f322e22a676309',
    messagingSenderId: '880576531628',
    projectId: 'socialchat-bba39',
    storageBucket: 'socialchat-bba39.appspot.com',
    iosBundleId: 'com.example.socialChat',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB7NGLF8a8uYryzFA0xTu6AJBIlOSkF4DI',
    appId: '1:880576531628:web:a80b709022b58b88676309',
    messagingSenderId: '880576531628',
    projectId: 'socialchat-bba39',
    authDomain: 'socialchat-bba39.firebaseapp.com',
    storageBucket: 'socialchat-bba39.appspot.com',
    measurementId: 'G-BMB96SFD6Y',
  );
}