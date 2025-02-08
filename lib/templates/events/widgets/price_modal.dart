import 'package:billit_now/apps/helper/theme/media_query_extended.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/component/app_switch.dart';
import 'package:billit_now/component/app_text_field.dart';
import 'package:flutter/material.dart';

class PriceModal extends StatefulWidget {
  final OverlayPortalController controller;
  final Offset offset;
  final double minValue;
  final double maxValue;
  final Function(double min, double max) onMinMaxValueChanged;
  final Function() onClearMinMaxPrice;
  final bool isFeesOn;
  final Function(bool value) onFeesChanged;
  final Widget child;

  const PriceModal({
    super.key,
    required this.controller,
    required this.offset,
    required this.minValue,
    required this.maxValue,
    required this.onMinMaxValueChanged,
    required this.onClearMinMaxPrice,
    required this.isFeesOn,
    required this.onFeesChanged,
    required this.child,
  });

  static final _link = LayerLink();

  @override
  State<PriceModal> createState() => _PriceModalState();
}

class _PriceModalState extends State<PriceModal> {
  ValueNotifier<double> min = ValueNotifier<double>(0);
  ValueNotifier<double> max = ValueNotifier<double>(0);

  late bool isFeesOn;

  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();

  @override
  initState() {
    super.initState();
    min.value = widget.minValue;
    max.value = widget.maxValue;

    isFeesOn = widget.isFeesOn;

    minController.text = formatToTwoDecimalPlaces(min.value);
    maxController.text = formatToTwoDecimalPlaces(max.value);

    min.addListener(() {
      minController.text = formatToTwoDecimalPlaces(min.value);
    });
    max.addListener(() {
      maxController.text = formatToTwoDecimalPlaces(max.value);
    });

    minController.addListener(() {
      Future.delayed(const Duration(milliseconds: 700), () {
        double? newValue = double.tryParse(minController.text);
        if (newValue != null && newValue != min.value) {
          setState(() {
            min.value = double.parse(minController.text);
          });
        }
      });
    });
    maxController.addListener(() {
      Future.delayed(const Duration(milliseconds: 700), () {
        double? newValue = double.tryParse(maxController.text);
        if (newValue != null && newValue != max.value) {
          setState(() {
            max.value = double.parse(maxController.text);
          });
        }
      });
    });
  }

  @override
  void dispose() {
    min.dispose();
    max.dispose();
    minController.dispose();
    maxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, limits) => OverlayPortal(
        controller: widget.controller,
        overlayChildBuilder: (context) => Stack(
          children: [
            ModalBarrier(
              onDismiss: () => widget.controller.hide(),
            ),
            CompositedTransformFollower(
                link: PriceModal._link,
                offset: widget.offset,
                targetAnchor: Alignment.centerLeft,
                child: Container(
                  width: context.logicalWidth < 1100 ? 300 : 400,
                  height: 300,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).appColors.bgSecondary,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                          color: Theme.of(context).appColors.borderSecondary)),
                  child: Column(
                    children: [
                      //slider
                      RangeSlider(
                        min: widget.minValue,
                        max: widget.maxValue,
                        activeColor:
                            Theme.of(context).appColors.fgBrandPrimary600,
                        inactiveColor:
                            Theme.of(context).appColors.bgSecondaryHover,
                        values: RangeValues(min.value, max.value),
                        onChanged: (values) {
                          setState(() {
                            min.value = values.start;
                            max.value = values.end;
                          });
                        },
                      ),
                      // Max Min textfield
                      Row(
                        children: [
                          Expanded(
                            child: AppTextField.main(
                                controller: minController,
                                labelText: 'Minimum',
                                keyboardType: TextInputType.number,
                                placeHolder: '',
                                helpText: '',
                                validator: (_) => null),
                          ),
                          SizedBox(width: 12.0),
                          Expanded(
                            child: AppTextField.main(
                                controller: maxController,
                                labelText: 'Maximum',
                                keyboardType: TextInputType.number,
                                placeHolder: '',
                                helpText: '',
                                validator: (_) => null),
                          )
                        ],
                      ),
                      SizedBox(height: 6.0),
                      // Fees
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Text('Show prices including fees',
                                style: Theme.of(context)
                                    .appTexts
                                    .textSmSemiBord
                                    .copyWith(
                                        color: Theme.of(context)
                                            .appColors
                                            .textSecondary700)),
                          ),
                          AppSwitch.main(
                            label: '',
                            enableColor:
                                Theme.of(context).appColors.bgBrandSolid,
                            diableColor: Theme.of(context).appColors.bgTertiary,
                            enable: isFeesOn,
                            onChange: (value) {
                              setState(() {
                                isFeesOn = value;
                              });
                            },
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Divider(
                            color: Theme.of(context).appColors.borderSecondary),
                      ),
                      // Clear & Apply Btn
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 50.0,
                            child: AppButton.buttonTertiary(
                                context: context,
                                text: 'Clear',
                                bgColor: Colors.transparent,
                                bgHoverColor: Colors.transparent,
                                textColor:
                                    Theme.of(context).appColors.fgTertiary600,
                                onTap: () {
                                  setState(() {
                                    widget.controller.toggle();
                                    widget.onClearMinMaxPrice();
                                    min.value = widget.minValue;
                                    max.value = widget.maxValue;
                                    isFeesOn = widget.isFeesOn;
                                  });
                                }),
                          ),
                          SizedBox(
                            width: 170.0,
                            child: AppButton.buttonPrimary(
                                context: context,
                                text: 'Apply',
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 8.0),
                                onTap: () {
                                  widget.controller.toggle();
                                  widget.onMinMaxValueChanged(
                                      min.value, max.value);
                                  widget.onFeesChanged(isFeesOn);
                                }),
                          )
                        ],
                      ),
                    ],
                  ),
                )),
          ],
        ),
        child: CompositedTransformTarget(
          link: PriceModal._link,
          child: InkWell(
              onTap: () => widget.controller.toggle(), child: widget.child),
        ),
      ),
    );
  }

  String formatToTwoDecimalPlaces(double number) {
    if (number <= 0) {
      return '0.00';
    }
    return number.toStringAsFixed(2);
  }
}
