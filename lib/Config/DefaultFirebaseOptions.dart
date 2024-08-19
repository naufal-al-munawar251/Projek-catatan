import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
        return linux;
      default:
        throw UnsupportedError('Unsupported platform');
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'your-web-api-key',
    appId: 'your-web-app-id',
    messagingSenderId: 'your-web-messaging-sender-id',
    projectId: 'your-project-id',
    authDomain: 'your-web-auth-domain',
    storageBucket: 'your-web-storage-bucket',
    measurementId: 'your-web-measurement-id',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDE-cLc4R-ny35NmqNpKSQCiE8eI8XPpg8',
    appId: '1:191702722318:android:966a072b2031f2daf5595f',
    messagingSenderId: '191702722318',
    projectId: 'fir-projek-a2681',
    storageBucket: 'fir-projek-a2681.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'your-ios-api-key',
    appId: 'your-ios-app-id',
    messagingSenderId: 'your-ios-messaging-sender-id',
    projectId: 'your-project-id',
    storageBucket: 'your-ios-storage-bucket',
    iosClientId: 'your-ios-client-id',
    iosBundleId: 'your-ios-bundle-id',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'your-macos-api-key',
    appId: 'your-macos-app-id',
    messagingSenderId: 'your-macos-messaging-sender-id',
    projectId: 'your-project-id',
    storageBucket: 'your-macos-storage-bucket',
    iosClientId: 'your-macos-client-id',
    iosBundleId: 'your-macos-bundle-id',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'your-windows-api-key',
    appId: 'your-windows-app-id',
    messagingSenderId: 'your-windows-messaging-sender-id',
    projectId: 'your-project-id',
    storageBucket: 'your-windows-storage-bucket',
  );

  static const FirebaseOptions linux = FirebaseOptions(
    apiKey: 'your-linux-api-key',
    appId: 'your-linux-app-id',
    messagingSenderId: 'your-linux-messaging-sender-id',
    projectId: 'your-project-id',
    storageBucket: 'your-linux-storage-bucket',
  );
}
