import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:flutter/material.dart';

class MainLogo extends StatelessWidget {
  const MainLogo({super.key, required this.iconName});

  final AppIconName iconName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
        border: Border.all(
            color: Theme.of(context).appColors.featuredIconModernBorder),
        color: Theme.of(context).appColors.bgPrimary,
      ),
      child: Center(
        child: AppIcon.logo(
          appIconName: iconName,
          context: context,
          size: 28,
        ),
      ),
    );
  }
}
