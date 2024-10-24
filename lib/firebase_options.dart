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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAsk3IOqPc_g3NrokaBapcs0oOqnWgKpwA',
    appId: '1:276621276267:android:ec69a03754b7351aef2d2e',
    messagingSenderId: '276621276267',
    projectId: 'hostel-management-cfe04',
    storageBucket: 'hostel-management-cfe04.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAHHvo8EjuQY_0a5ei8oZen7Zz487ILJwo',
    appId: '1:276621276267:ios:98c35b29f64edb0fef2d2e',
    messagingSenderId: '276621276267',
    projectId: 'hostel-management-cfe04',
    storageBucket: 'hostel-management-cfe04.appspot.com',
    iosBundleId: 'com.example.goku',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBB-dGH1wzxmzzw5XinfyQS37-93XyLqsw',
    appId: '1:276621276267:web:a7d1015af46adc30ef2d2e',
    messagingSenderId: '276621276267',
    projectId: 'hostel-management-cfe04',
    authDomain: 'hostel-management-cfe04.firebaseapp.com',
    storageBucket: 'hostel-management-cfe04.appspot.com',
    measurementId: 'G-Y9J3JVBVGW',
  );
}
