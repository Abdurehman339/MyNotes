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
    apiKey: 'AIzaSyC7E_Mc-B-v-Ta4bqDjpzDA3jlEKR3PDNo',
    appId: '1:354317122212:web:41045def26d7b5b5e08431',
    messagingSenderId: '354317122212',
    projectId: 'notes-c14d3',
    authDomain: 'notes-c14d3.firebaseapp.com',
    storageBucket: 'notes-c14d3.appspot.com',
    measurementId: 'G-EC4WR92KCF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBnLf3kFiB2Pqt6H0bwsg-LkOVBc6-nON4',
    appId: '1:354317122212:android:de509a1615cc5a8fe08431',
    messagingSenderId: '354317122212',
    projectId: 'notes-c14d3',
    storageBucket: 'notes-c14d3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyALkMmtNDUKYG5ErdDAEvxDXhI4vq-jblE',
    appId: '1:354317122212:ios:402e20fc53f279f6e08431',
    messagingSenderId: '354317122212',
    projectId: 'notes-c14d3',
    storageBucket: 'notes-c14d3.appspot.com',
    iosBundleId: 'com.example.myNotes',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyALkMmtNDUKYG5ErdDAEvxDXhI4vq-jblE',
    appId: '1:354317122212:ios:b9f4e7685ef94eb9e08431',
    messagingSenderId: '354317122212',
    projectId: 'notes-c14d3',
    storageBucket: 'notes-c14d3.appspot.com',
    iosBundleId: 'com.example.myNotes.RunnerTests',
  );
}
