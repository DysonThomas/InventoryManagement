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
    apiKey: 'AIzaSyD70BwKWz1PCyThEEnbAvuXmZhwxH4jdlg',
    appId: '1:827345323244:web:2225d4f7f86974274311c9',
    messagingSenderId: '827345323244',
    projectId: 'inventorymanagement-4b725',
    authDomain: 'inventorymanagement-4b725.firebaseapp.com',
    storageBucket: 'inventorymanagement-4b725.firebasestorage.app',
    measurementId: 'G-RFW0Y4C48R',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAD20DDC4eoDCDbHp1gXDuzmJzHgFObeHE',
    appId: '1:827345323244:android:f35579487c1b76a44311c9',
    messagingSenderId: '827345323244',
    projectId: 'inventorymanagement-4b725',
    storageBucket: 'inventorymanagement-4b725.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCD7wnvEgOzBCl88a-7-xjencbfWqNm4RI',
    appId: '1:827345323244:ios:d36cf3fc9a30c66d4311c9',
    messagingSenderId: '827345323244',
    projectId: 'inventorymanagement-4b725',
    storageBucket: 'inventorymanagement-4b725.firebasestorage.app',
    iosBundleId: 'com.example.inventorymanagement',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCD7wnvEgOzBCl88a-7-xjencbfWqNm4RI',
    appId: '1:827345323244:ios:d36cf3fc9a30c66d4311c9',
    messagingSenderId: '827345323244',
    projectId: 'inventorymanagement-4b725',
    storageBucket: 'inventorymanagement-4b725.firebasestorage.app',
    iosBundleId: 'com.example.inventorymanagement',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD70BwKWz1PCyThEEnbAvuXmZhwxH4jdlg',
    appId: '1:827345323244:web:1ff8311e6bbd2fd84311c9',
    messagingSenderId: '827345323244',
    projectId: 'inventorymanagement-4b725',
    authDomain: 'inventorymanagement-4b725.firebaseapp.com',
    storageBucket: 'inventorymanagement-4b725.firebasestorage.app',
    measurementId: 'G-R8CLZ629H5',
  );
}
