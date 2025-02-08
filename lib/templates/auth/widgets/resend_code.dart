import 'dart:async';

import 'package:billit_now/features/base/base_stateful_widget.dart';
import 'package:billit_now/templates/landing/spotlight.dart';
import 'package:billit_now/templates/shared/Utils.dart';
import 'package:flutter/cupertino.dart';

import '../../../component/app_button.dart';

class ResendCode extends BaseStatefulWidget {

  ResendCode({ required this.click});
  final Function() click;

  @override
  State<StatefulWidget> createState() { return _ResendCode(); }

}

class _ResendCode extends BaseWidgetState<ResendCode> {

  Timer? _timer;
  int _seconds = 60; // Start counting from 60 seconds
  bool _isButtonEnabled = false;

  void _resetState() {
    _timer?.cancel();
    _seconds = 60;
    _isButtonEnabled = false;
  }

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    _timer?.cancel(); // Clean up the timer when the widget is disposed
    super.dispose();
  }

  void _startCountdown() {
    _resetState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (--_seconds == 0) {
          _isButtonEnabled = true;
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget body(BuildContext context) {
    return Expanded(
      child: AppButton.buttonPrimary(
        text: _seconds != 0
            ? getString("resend_code_[placeholder]")
                .replaceFirst("[placeholder]", _seconds.toNumberString(getLanguage()))
            : getString("resend_code"),
        context: context,
        disable: !_isButtonEnabled,
        padding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 10),
        onTap: () {
          _startCountdown();
          widget.click();
        },
      ),
    );
  }

}