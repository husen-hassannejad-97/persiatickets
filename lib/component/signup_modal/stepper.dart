import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/repositories/event_map/models/stepper_num.dart';
import 'package:flutter/material.dart';

class StepperSignUp extends StatelessWidget {
  const StepperSignUp({super.key, required this.step});
  final StepperNum step;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 200,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              height: 5,
              decoration: BoxDecoration(
                color: Theme.of(context).appColors.bgBrand,
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              height: 5,
              decoration: BoxDecoration(
                color: step == StepperNum.step2 || step == StepperNum.step3
                    ? Theme.of(context).appColors.bgBrand
                    : Theme.of(context).appColors.bgDisabled,
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              height: 5,
              decoration: BoxDecoration(
                color: step == StepperNum.step3
                    ? Theme.of(context).appColors.bgBrand
                    : Theme.of(context).appColors.bgDisabled,
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
