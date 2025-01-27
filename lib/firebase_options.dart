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
    apiKey: 'AIzaSyAv70cxlkwoxP-cytnV4kRjWaQi86QA9d0',
    appId: '1:285013628013:web:a9d4a149d7fddac50edb64',
    messagingSenderId: '285013628013',
    projectId: 'rentndeal-05',
    authDomain: 'rentndeal-05.firebaseapp.com',
    storageBucket: 'rentndeal-05.appspot.com',
    measurementId: 'G-T48VS6VPFE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBdGF-Wlxyz8CgmlVKTvOaI3cuB85PhVEc',
    appId: '1:285013628013:android:b6855906df61632a0edb64',
    messagingSenderId: '285013628013',
    projectId: 'rentndeal-05',
    storageBucket: 'rentndeal-05.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAIZF9dUzELIhWCQvFBI4gWRzFsHvf2NYA',
    appId: '1:285013628013:ios:b284971596f777970edb64',
    messagingSenderId: '285013628013',
    projectId: 'rentndeal-05',
    storageBucket: 'rentndeal-05.appspot.com',
    androidClientId: '285013628013-2ac5075el3gu1kcetpo66tgc3a8huvem.apps.googleusercontent.com',
    iosClientId: '285013628013-2drtk2ms4c5nrfdh40n5goebumfkh26v.apps.googleusercontent.com',
    iosBundleId: 'com.example.rentndeal',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAIZF9dUzELIhWCQvFBI4gWRzFsHvf2NYA',
    appId: '1:285013628013:ios:b284971596f777970edb64',
    messagingSenderId: '285013628013',
    projectId: 'rentndeal-05',
    storageBucket: 'rentndeal-05.appspot.com',
    androidClientId: '285013628013-2ac5075el3gu1kcetpo66tgc3a8huvem.apps.googleusercontent.com',
    iosClientId: '285013628013-2drtk2ms4c5nrfdh40n5goebumfkh26v.apps.googleusercontent.com',
    iosBundleId: 'com.example.rentndeal',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAv70cxlkwoxP-cytnV4kRjWaQi86QA9d0',
    appId: '1:285013628013:web:fef13862870704240edb64',
    messagingSenderId: '285013628013',
    projectId: 'rentndeal-05',
    authDomain: 'rentndeal-05.firebaseapp.com',
    storageBucket: 'rentndeal-05.appspot.com',
    measurementId: 'G-V220WBQ0RZ',
  );

}