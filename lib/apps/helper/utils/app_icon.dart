import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcon extends StatelessWidget {
  final String name;
  final Color? color;
  final double? size;
  final bool isNetwork;

  const AppIcon._internal({
    super.key,
    required this.name,
    this.color,
    this.size,
    this.isNetwork = false,
  });

  factory AppIcon.logo(
          {Key? key,
          required AppIconName appIconName,
          required BuildContext context,
          required double size}) =>
      AppIcon._internal(
        key: key,
        name: appIconName.name,
        size: size,
      );

  factory AppIcon.button(
          {Key? key,
          required AppIconName appIconName,
          required BuildContext context,
          double? size,
          Color? color}) =>
      AppIcon._internal(
        key: key,
        name: appIconName.name,
        size: size ?? 24,
        color: color,
      );

  factory AppIcon.img(
          {Key? key,
          required String image,
          required BuildContext context,
          double? size,
          Color? color}) =>
      AppIcon._internal(
        key: key,
        name: image,
        size: size ?? 24,
        color: color,
        isNetwork: true,
      );

  @override
  Widget build(BuildContext context) {
    return isNetwork
        ? Image.network(
            name,
            width: size,
            height: size,
            color: color,
            alignment: Alignment.center,
            fit: BoxFit.contain,
          )
        : SvgPicture.asset(
            name,
            colorFilter: color == null
                ? null
                : ColorFilter.mode(color!, BlendMode.srcIn),
            width: size,
            height: size,
            alignment: Alignment.center,
          );
  }
}
