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
    apiKey: 'AIzaSyAmTT99ynYH9RD5ApI2VDfol3Cd89Mcw_U',
    appId: '1:669071507586:web:33d3f821174addcbf7349b',
    messagingSenderId: '669071507586',
    projectId: 'todoapp-b1ab1',
    authDomain: 'todoapp-b1ab1.firebaseapp.com',
    storageBucket: 'todoapp-b1ab1.firebasestorage.app',
    measurementId: 'G-NDNKN5CQ9C',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCNplazmacRFP16EE2LK0lmNV6xrS5DRBI',
    appId: '1:669071507586:android:fef6919baa30d219f7349b',
    messagingSenderId: '669071507586',
    projectId: 'todoapp-b1ab1',
    storageBucket: 'todoapp-b1ab1.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCllbsD9nIok6Fdo4hY3ktZ3ESpGH-tf-c',
    appId: '1:669071507586:ios:1a14b65f1386d1b1f7349b',
    messagingSenderId: '669071507586',
    projectId: 'todoapp-b1ab1',
    storageBucket: 'todoapp-b1ab1.firebasestorage.app',
    iosBundleId: 'com.example.untitled3',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCllbsD9nIok6Fdo4hY3ktZ3ESpGH-tf-c',
    appId: '1:669071507586:ios:1a14b65f1386d1b1f7349b',
    messagingSenderId: '669071507586',
    projectId: 'todoapp-b1ab1',
    storageBucket: 'todoapp-b1ab1.firebasestorage.app',
    iosBundleId: 'com.example.untitled3',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAmTT99ynYH9RD5ApI2VDfol3Cd89Mcw_U',
    appId: '1:669071507586:web:06ad42abdbd4e75ef7349b',
    messagingSenderId: '669071507586',
    projectId: 'todoapp-b1ab1',
    authDomain: 'todoapp-b1ab1.firebaseapp.com',
    storageBucket: 'todoapp-b1ab1.firebasestorage.app',
    measurementId: 'G-SKCZVJRRVS',
  );
}
