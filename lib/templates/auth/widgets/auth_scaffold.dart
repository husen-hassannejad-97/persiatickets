import 'package:billit_now/apps/helper/theme/media_query_extended.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/component/header.dart';
import 'package:billit_now/component/nav_drawer.dart';
import 'package:flutter/material.dart';

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({super.key, this.scrollController, required this.body});

  final ScrollController? scrollController;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appColors.bgSecondary,
      endDrawer: const NavDrawer(),
      body: SafeArea(
          child: Center(
        child: Container(
          height: context.logicalHeightSA,
          constraints: BoxConstraints(
              maxWidth: context.logicalWidth, minHeight: context.logicalHeight),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).appColors.bgBrand,
                Theme.of(context).appColors.bgSecondary,
              ],
              stops: const [0, 1],
              begin: const Alignment(0.0, 1.5),
              end: const Alignment(0.0, 0.5),
            ),
          ),
          child: Stack(
            children: [body, Header(scrollController: scrollController!)],
          ),
        ),
      )),
    );
  }
}
