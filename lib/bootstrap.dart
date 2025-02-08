import 'dart:async';
import 'dart:developer';

import 'package:billit_now/core/di/di_setup.dart';
import 'package:billit_now/core/localization/localize.dart';
import 'package:billit_now/templates/app/app.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> bootstrap() async {

  await Hive.initFlutter();
  await getIt<Localize>().initValues();

  ///
  /// print all state change errors about [Bloc] library in console.
  ///
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  ///
  /// observes all state changes about [Bloc] library.
  ///
  // Bloc.observer = const GlobalObserver();

  // final AppRepository appRepository = AppRepository();

  // if (kIsWeb) {
  //   await FacebookAuth.i.webAndDesktopInitialize(
  //     cookie: true,
  //     xfbml: true,
  //     version: "v15.0",
  //   );
  // }
  runApp(App());
}
