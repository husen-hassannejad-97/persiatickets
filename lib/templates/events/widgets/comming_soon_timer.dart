import 'dart:async';

import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:flutter/material.dart';

class CommingSoonTimer extends StatefulWidget {
  const CommingSoonTimer({super.key, required this.duration});

  final Duration duration;

  @override
  State<CommingSoonTimer> createState() => _CommingSoonTimerState();
}

class _CommingSoonTimerState extends State<CommingSoonTimer> {
  Timer? countdownTimer;
  late Duration duration;
  @override
  void initState() {
    duration = widget.duration;
    startTimer();
    super.initState();
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = duration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final days = strDigits(duration.inDays);

    final hours = strDigits(duration.inHours.remainder(24));
    final minutes = strDigits(duration.inMinutes.remainder(60));
    final seconds = strDigits(duration.inSeconds.remainder(60));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _timeContainer(days, 'Days'),
        _spliter(),
        _timeContainer(hours, 'Hours'),
        _spliter(),
        _timeContainer(minutes, 'Minutes'),
        _spliter(),
        _timeContainer(seconds, 'Seconds'),
      ],
    );
  }

  _timeContainer(String time, String title) => Column(
        children: [
          Container(
              margin: EdgeInsets.only(bottom: 2.0),
              padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).appColors.borderSecondary,
                      width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(6.0))),
              child: Text(
                time,
                style: Theme.of(context).appTexts.textSmMedium.copyWith(
                    color: Theme.of(context).appColors.textTeritory600),
              )),
          Text(
            title,
            style: Theme.of(context)
                .appTexts
                .textXsMedium
                .copyWith(color: Theme.of(context).appColors.textQuaternary500),
          )
        ],
      );

  _spliter() => Padding(
        padding: EdgeInsets.only(top: 6.0, bottom: 17.0, left: 8.0, right: 8.0),
        child: Text(
          ':',
          style: Theme.of(context)
              .appTexts
              .textLgRegular
              .copyWith(color: Theme.of(context).appColors.textQuaternary500),
        ),
      );
}
