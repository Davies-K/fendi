import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'home_view_desktop.dart';
import 'home_view_mobile.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      return Scaffold(
          body: ScreenTypeLayout(
              mobile: HomeMobileView(),
              tablet: HomeDesktopView(),
              desktop: HomeDesktopView()));
    });
  }
}
