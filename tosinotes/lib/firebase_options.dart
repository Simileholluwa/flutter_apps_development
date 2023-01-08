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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAFJi7p7IoQ2lGNrajBVU_tHEUH5Jo8agA',
    appId: '1:1037199281320:android:a3c1391bcdd4de0fed469d',
    messagingSenderId: '1037199281320',
    projectId: 'tosinotes',
    storageBucket: 'tosinotes.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCOrGooxwWh4O0n5CwGzmfghEExpSDL1Ao',
    appId: '1:1037199281320:ios:40533b0042884fbfed469d',
    messagingSenderId: '1037199281320',
    projectId: 'tosinotes',
    storageBucket: 'tosinotes.appspot.com',
    iosClientId: '1037199281320-0k02homfbp8htpv1rum2783n0jl8l0ka.apps.googleusercontent.com',
    iosBundleId: 'io.prodigy.tosinotes',
  );
}
