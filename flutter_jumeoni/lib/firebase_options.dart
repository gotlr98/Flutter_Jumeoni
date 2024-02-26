// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCfoP9wFVshb9r4y-i3koI5c7cvyKIj8sM',
    appId: '1:766799343918:web:85c211a759b1cab62b4abf',
    messagingSenderId: '766799343918',
    projectId: 'flutterjumeoni-b1615',
    authDomain: 'flutterjumeoni-b1615.firebaseapp.com',
    storageBucket: 'flutterjumeoni-b1615.appspot.com',
    measurementId: 'G-T2QRPXWLWZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBiIlta_9npp5qWWBAQff2vykGS-qlUXgo',
    appId: '1:766799343918:android:1c96a19cc931202f2b4abf',
    messagingSenderId: '766799343918',
    projectId: 'flutterjumeoni-b1615',
    storageBucket: 'flutterjumeoni-b1615.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCvFcYhg2vA3U0h-302u0flGkimI9194hU',
    appId: '1:766799343918:ios:63ab48b06e27782b2b4abf',
    messagingSenderId: '766799343918',
    projectId: 'flutterjumeoni-b1615',
    storageBucket: 'flutterjumeoni-b1615.appspot.com',
    iosBundleId: 'com.example.flutterJumeoni',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCvFcYhg2vA3U0h-302u0flGkimI9194hU',
    appId: '1:766799343918:ios:c08fb8bc10f406732b4abf',
    messagingSenderId: '766799343918',
    projectId: 'flutterjumeoni-b1615',
    storageBucket: 'flutterjumeoni-b1615.appspot.com',
    iosBundleId: 'com.example.flutterJumeoni.RunnerTests',
  );
}
