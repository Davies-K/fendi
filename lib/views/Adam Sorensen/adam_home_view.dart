import 'package:fendi/views/Adam%20Sorensen/adam_desktop.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'adam_mobile.dart';

class AdamHome extends StatefulWidget {
  @override
  _AdamHomeState createState() => _AdamHomeState();
}

class _AdamHomeState extends State<AdamHome> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      return Scaffold(
          body: ScreenTypeLayout(
              mobile: AdamMobileView(),
              tablet: AdamDesktopView(),
              desktop: AdamDesktopView()));
    });
  }
}
