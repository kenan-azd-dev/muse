import 'dart:developer';

import 'package:flutter/material.dart';

// 3rd Party Packages
import 'package:bloc/bloc.dart';

// Project Files
import 'ui/app/app_bloc_observer.dart';
import 'ui/app/app_wrapper.dart';

void bootstrap() {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  runApp(const MuseApp());
}
