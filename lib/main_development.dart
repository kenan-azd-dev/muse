import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

// 3rd Party Packages
// import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Project Files
import './di/injection_container.dart';
import './bootstrap.dart';
import './firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kDebugMode) {
    try {
      String localhost = '192.168.1.104';
      // await FirebaseAppCheck.instance.activate(
      //   webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
      //   androidProvider: AndroidProvider.debug,
      //   appleProvider: AppleProvider.debug,
      // );
      FirebaseFirestore.instance.useFirestoreEmulator(localhost, 8080);
      await FirebaseAuth.instance.useAuthEmulator(localhost, 9099);
      FirebaseStorage.instance.useStorageEmulator(localhost, 9199);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  await initDependencies();

  bootstrap();
}
