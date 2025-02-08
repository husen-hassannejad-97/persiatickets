import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../core/di/di_setup.dart';
import '../../core/localization/languages.dart';
import '../../core/localization/layout_direction.dart';
import '../../core/localization/localize.dart';
import '../shared/CustomValueListenableBuilder.dart';
import 'base_bloc_event.dart';
import 'base_widget_mixin.dart';
import 'event_bloc.dart';

abstract class BaseStatelessWidget extends StatelessWidget with BaseWidgetMixin {
  BaseStatelessWidget({super.key});

  double _lastVisibilityFraction = 0.0;

  @override
  Widget build(BuildContext context) {
    if(visibilityDetection) {
      return VisibilityDetector(
          key: visibilityKey,
          child: ValueListenableBuilder(
              valueListenable: getIt<Localize>().selectedLanguage,
              builder: (context, value, child) {
                return body(context);
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
                child: body(context),
              );
            } else {
              return body(context);
            }
          });
    }
  }

  void onLanguageChange(BuildContext context, Language language) {}

  void addEvent(BuildContext context, BaseBlocEvent event) {
    context.read<EventBloc>().add(event);
  }

  Widget body(BuildContext context);
}
