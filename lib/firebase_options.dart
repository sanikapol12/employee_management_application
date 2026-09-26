// File generated and configured for employee_management_application
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      default:
        return android;
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBvD7UwQM1bOHGgkL5v84qS71HvzBtXQm4',
    appId: '1:124290861275:web:c84d0df9c14bd64e8f24fe',
    messagingSenderId: '124290861275',
    projectId: 'employeemanagementapplic-4f417',
    authDomain: 'employeemanagementapplic-4f417.firebaseapp.com',
    storageBucket: 'employeemanagementapplic-4f417.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBvD7UwQM1bOHGgkL5v84qS71HvzBtXQm4',
    appId: '1:124290861275:android:c84d0df9c14bd64e8f24fe',
    messagingSenderId: '124290861275',
    projectId: 'employeemanagementapplic-4f417',
    storageBucket: 'employeemanagementapplic-4f417.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBvD7UwQM1bOHGgkL5v84qS71HvzBtXQm4',
    appId: '1:124290861275:ios:c84d0df9c14bd64e8f24fe',
    messagingSenderId: '124290861275',
    projectId: 'employeemanagementapplic-4f417',
    storageBucket: 'employeemanagementapplic-4f417.firebasestorage.app',
    iosBundleId: 'com.example.employeeManagementApplication',
  );
}
