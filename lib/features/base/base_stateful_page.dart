import 'package:billit_now/core/di/di_setup.dart';
import 'package:billit_now/core/localization/localize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/localization/languages.dart';
import '../../core/localization/layout_direction.dart';
import '../shared/CustomValueListenableBuilder.dart';
import 'base_bloc_event.dart';
import 'base_page_mixin.dart';
import 'event_bloc.dart';

abstract class BaseStatefulPage extends StatefulWidget {
  const BaseStatefulPage({super.key});
}

abstract class BasePageState<Page extends BaseStatefulPage> extends State<Page> with BasePageMixin {
  @override
  Widget build(BuildContext context) {
    var providers = setProviders(context);
    providers.add(BlocProvider(create: (context) => EventBloc()));
    return MultiBlocProvider(
        providers: [...providers],
        child: BlocListener<EventBloc, BaseBlocEvent>(
          listener: (context, state) {
            consumeEvent(context, state);
          },
          child: CustomValueListenableBuilder(
              valueListenable: getIt<Localize>().selectedLanguage,
              listener: (context) {
                onLanguageChange(context, getIt<Localize>().selectedLanguage.value);
              },
              builder: (context, value, child) {
                if(allowRTLDirectionality()) {
                  return Directionality(
                    textDirection: getLayoutDirection() == LayoutDirection.ltr ?
                    TextDirection.ltr : TextDirection.rtl,
                    child: body(context),
                  );
                } else {
                  return body(context);
                }
              }),
        )
    );
  }

  void onLanguageChange(BuildContext context, Language language) {}

  void consumeEvent(BuildContext context, BaseBlocEvent event) {}

  void addEvent(BuildContext context, BaseBlocEvent event) {
    context.read<EventBloc>().add(event);
  }

  Widget body(BuildContext context);
}
