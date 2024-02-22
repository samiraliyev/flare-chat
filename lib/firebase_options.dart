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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCaM93bVlXekUhT38LDoirCdkSj5qGmi2w',
    appId: '1:727287547500:web:0fd6f737d2cef76d383a49',
    messagingSenderId: '727287547500',
    projectId: 'flare-chat-98a28',
    authDomain: 'flare-chat-98a28.firebaseapp.com',
    storageBucket: 'flare-chat-98a28.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBYGKobpsKRH_XUVTjyVYIvbj_C-cJeDBE',
    appId: '1:727287547500:android:9f56c9afde3d5121383a49',
    messagingSenderId: '727287547500',
    projectId: 'flare-chat-98a28',
    storageBucket: 'flare-chat-98a28.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAtuIsNAh-yAmJOuWTzcEktSCOIKnsmFUQ',
    appId: '1:727287547500:ios:0203593a7c3578d7383a49',
    messagingSenderId: '727287547500',
    projectId: 'flare-chat-98a28',
    storageBucket: 'flare-chat-98a28.appspot.com',
    androidClientId: '727287547500-nn993543a96su9ookocfbg8r1dk1b6pu.apps.googleusercontent.com',
    iosClientId: '727287547500-nmlcoo2dvfkommpajvvrtq9b9lf5a2g1.apps.googleusercontent.com',
    iosBundleId: 'com.example.flareChatApp',
  );
}