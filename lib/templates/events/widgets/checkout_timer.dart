import 'dart:async';

import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CheckoutTimer extends StatefulWidget {
  const CheckoutTimer(
      {super.key, required this.duration, required this.currentTime});

  final Duration duration;
  final Function(Duration) currentTime;

  @override
  State<CheckoutTimer> createState() => _CheckoutTimerState();
}

class _CheckoutTimerState extends State<CheckoutTimer> {
  Timer? timer;
  Duration duration = Duration();

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  void addTime() {
    final addSeconds = -1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      if (seconds < 0) {
        timer?.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
    });

    widget.currentTime(duration);
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  void initState() {
    super.initState();
    duration = widget.duration;
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
          color: Theme.of(context).appColors.bgWarningSecondary,
          border:
              Border.all(color: Theme.of(context).appColors.utilityWarning200),
          borderRadius: BorderRadius.circular(8.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              AppIcon.button(
                  appIconName: AppIconName.uecf4ClockStopwatch,
                  color: Theme.of(context).appColors.fgWarningPrimary,
                  size: 20.0,
                  context: context),
              SizedBox(width: 6.0),
              Text('Time Left: ${formatDuration(duration)}',
                  style: Theme.of(context).appTexts.textMdMedium.copyWith(
                      color: Theme.of(context).appColors.utilityWarning700))
            ],
          ),
          SizedBox(
            height: 30,
            child: AppButton.buttonTertiary(
                context: context,
                text: 'Cancel',
                bgHoverColor: Colors.transparent,
                onTap: () => context.pop()),
          )
        ],
      ),
    );
  }
}
