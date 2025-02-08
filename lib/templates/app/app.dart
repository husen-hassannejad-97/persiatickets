import 'package:billit_now/apps/helper/router/app_router.dart';
import 'package:billit_now/apps/helper/theme/app_colors_theme.dart';
import 'package:billit_now/apps/helper/theme/app_dimensions_theme.dart';
import 'package:billit_now/apps/helper/theme/app_texts_theme.dart';
import 'package:billit_now/core/di/di_setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class App extends StatelessWidget {
  // final AppRepository appRepository;

  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // return MultiRepositoryProvider(
    //     providers: [
    //       RepositoryProvider.value(value: appRepository),
    //     ],
    //     child: MultiBlocProvider(providers: [
    //       BlocProvider<AppCubit>(create: (BuildContext abContext) => AppCubit())
    //     ], child: const AppView()));

    return AppView();
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    // change system statusBar & navBar color
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Color(0xFFE9E9E9),
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Color(0xFFE9E9E9),
        systemNavigationBarIconBrightness: Brightness.dark));

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context).copyWith(
        extensions: [
          AppDimensionsTheme.main(context),
          AppColorsTheme.dark(),
          AppTextsTheme.main(),
        ],
      ),
      routerConfig: getIt<GoRouter>(),
    );
  }
}
