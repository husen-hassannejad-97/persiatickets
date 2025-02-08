import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:flutter/material.dart';

class CommentTextField extends StatefulWidget {
  const CommentTextField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<CommentTextField> createState() => _CommentTextFieldState();
}

class _CommentTextFieldState extends State<CommentTextField> {
  final int _maxLength = 500;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      maxLength: _maxLength,
      maxLines: null,
      expands: true,
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.top,
      cursorColor: Theme.of(context).appColors.borderBrand,
      style: Theme.of(context)
          .appTexts
          .textMdRegular
          .copyWith(color: Theme.of(context).appColors.textPrimary900),
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Theme.of(context).appColors.borderPrimary,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Theme.of(context).appColors.borderPrimary,
            width: 1.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Theme.of(context).appColors.borderError,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Theme.of(context).appColors.borderBrand,
            width: 1.0,
          ),
        ),
        hintText: 'Write your feedback here...',
        fillColor: Theme.of(context).appColors.bgSecondary,
        hintStyle: Theme.of(context)
            .appTexts
            .textMdMedium
            .copyWith(color: Theme.of(context).appColors.textPlaceholder),
        counterText: '${widget.controller.text.length}/$_maxLength',
      ),
      onChanged: (text) {
        setState(() {}); // Update counter dynamically
      },
    );
  }
}
