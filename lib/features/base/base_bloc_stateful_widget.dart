import 'package:billit_now/core/localization/layout_direction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../core/di/di_setup.dart';
import '../../core/localization/languages.dart';
import '../../core/localization/localize.dart';
import '../shared/CustomValueListenableBuilder.dart';
import 'base_bloc.dart';
import 'base_bloc_event.dart';
import 'base_bloc_state.dart';
import 'base_widget_mixin.dart';
import 'event_bloc.dart';

abstract class BaseBlocStatefulWidget extends StatefulWidget {
  const BaseBlocStatefulWidget({super.key});
}

abstract class BaseBlocStateWidget<_Widget extends BaseBlocStatefulWidget,
    Bloc extends BaseBloc> extends State<_Widget> with BaseWidgetMixin, AutomaticKeepAliveClientMixin<_Widget> {
  double _lastVisibilityFraction = 0.0;
  @override
  bool get wantKeepAlive => false;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) {
        Bloc bloc = getIt<Bloc>();
        preConfigBloc(context, bloc);
        return bloc;
      },
      child: BlocListener<Bloc, BaseBlocState>(listener: (context, state) {
        consumeState(context, state);
      }, child: BlocBuilder<Bloc, BaseBlocState>(builder: (context, state) {
        if(visibilityDetection) {
          return VisibilityDetector(
            key: visibilityKey,
            child: ValueListenableBuilder(
                valueListenable: getIt<Localize>().selectedLanguage,
                builder: (context, value, child) {
                  if(allowRTLDirectionality()) {
                    return Directionality(
                      textDirection: getLayoutDirection() == LayoutDirection.ltr ?
                      TextDirection.ltr : TextDirection.rtl,
                      child: body(context, state),
                    );
                  } else {
                    return body(context, state);
                  }
                }),
            onVisibilityChanged: (VisibilityInfo info) {
              if(_lastVisibilityFraction == 0.0 && info.visibleFraction > 0) {
                onVisible(context);
              } else if(_lastVisibilityFraction > 0.0 && info.visibleFraction == 0.0) {
                onInvisible(context);
              }
              onVisibleFraction(context, info.visibleFraction);
              _lastVisibilityFraction = info.visibleFraction;
            },
          );
        } else {
          return CustomValueListenableBuilder(
              valueListenable: getIt<Localize>().selectedLanguage,
              listener: (context) {
                onLanguageChange(context, getIt<Localize>().selectedLanguage.value);
              },
              builder: (context, value, child) {
                if(allowRTLDirectionality()) {
                  return Directionality(
                    textDirection: getLayoutDirection() == LayoutDirection.ltr ?
                    TextDirection.ltr : TextDirection.rtl,
                    child: body(context, state),
                  );
                } else {
                  return body(context, state);
                }
              });
        }
      })),
    );
  }

  void onLanguageChange(BuildContext context, Language language) {}

  void preConfigBloc(BuildContext context, Bloc bloc) {}

  void addEvent(BuildContext context, BaseBlocEvent event) {
    context.read<EventBloc>().add(event);
    context.read<Bloc>().add(event);
  }

  void consumeState(BuildContext context, BaseBlocState state) {}

  Widget body(BuildContext context, BaseBlocState state);
}
