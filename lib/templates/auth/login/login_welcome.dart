import 'dart:async';

import 'package:billit_now/apps/helper/router/router_extention/landing_router_extention.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/features/base/base_stateless_widget.dart';
import 'package:flutter/material.dart';

class LoginWelcome extends BaseStatelessWidget {

  @override
  bool get visibilityDetection => true;

  @override
  Key get visibilityKey => Key("login_welcome");

  Timer? timer;

  @override
  bool allowRTLDirectionality() => true;
  
  @override
  void onVisible(BuildContext context) {
    super.onVisible(context);
    timer?.cancel();
    timer = Timer(Duration(seconds: 2), () {
      context.goLanding();
    });
  }

  @override
  Widget body(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Container(
        color: Theme.of(context).appColors.bgPrimary,
        child: Center(
          child: Text(getString("welcome"), style: Theme.of(context).appTexts.displayLgSemibold.copyWith(
              color: Theme.of(context).appColors.textWhite)),
        ),
      ),
    );
  }
  
}