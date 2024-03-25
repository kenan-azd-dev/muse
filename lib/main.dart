import 'package:flutter/material.dart';

// Project Files
import './di/injection_container.dart';
import './bootstrap.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  bootstrap();
}


