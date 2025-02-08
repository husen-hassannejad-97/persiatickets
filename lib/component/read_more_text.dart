import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:flutter/material.dart';

class ReadMoreText extends StatefulWidget {
  final String text;
  final int trimLength;
  final TextStyle? style;
  final TextStyle? trimTextStyle;

  const ReadMoreText({
    required this.text,
    this.trimLength = 100,
    this.style,
    this.trimTextStyle,
    super.key,
  });

  @override
  State<ReadMoreText> createState() => _ReadMoreTextState();
}

class _ReadMoreTextState extends State<ReadMoreText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final displayText = _isExpanded
        ? widget.text
        : widget.text.length > widget.trimLength
            ? '${widget.text.substring(0, widget.trimLength)}...'
            : widget.text;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          displayText,
          style: widget.style,
        ),
        if (widget.text.length > widget.trimLength)
          Container(
              width: 120.0,
              padding: const EdgeInsets.only(top: 6.0),
              child: AppButton.buttonIcon(
                  _isExpanded
                      ? AppIconName.uea25ChevronUp
                      : AppIconName.uea1dChevronDown,
                  text: _isExpanded ? 'Read less' : 'Read more',
                  iconSize: 20.0,
                  iconColor: Theme.of(context).appColors.buttonTeritoryFg,
                  bgColor: Colors.transparent,
                  bgHoverColor: Colors.transparent,
                  textColor: Theme.of(context).appColors.buttonTeritoryFg,
                  context: context, onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              })),
      ],
    );
  }
}
