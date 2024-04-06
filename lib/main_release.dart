import 'package:flutter/material.dart';

// 3rd Party Packages
import 'package:firebase_core/firebase_core.dart';

// Project Files
import './di/injection_container.dart';
import './bootstrap.dart';
import './firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initDependencies();

  bootstrap();
}
