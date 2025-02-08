import 'dart:io';

import 'package:billit_now/features/base/base_stateless_widget.dart';
import 'package:billit_now/templates/auth/widgets/login_apple.dart';
import 'package:billit_now/templates/auth/widgets/login_facebook.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'login_google.dart';

class LoginSignOptions extends BaseStatelessWidget {
  LoginSignOptions({super.key});

  @override
  Widget body(BuildContext context) {
    List<Widget> children = [];
    children.add(LoginGoogle(isEnabled: true,));
    children.add(LoginFacebook(isEnabled: false,));
    // if(!kIsWeb && Platform.isIOS) {
      children.add(LoginApple(isEnabled: false,));
    // }
    return Column(
      children: children,
    );
  }
}
