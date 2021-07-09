import 'package:fendi/Utils/utils.dart';
import 'package:fendi/constants/constants.dart';
import 'package:flutter/material.dart';

class BottomLink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: Utils.screenHeight * 0.05,
        right: 0,
        child: Container(
          //width: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(AppPhrases.locator, style: AppStyles.bottomLinkTextStyle),
              AppSpaces.smallLinkSpace,
              Text(AppPhrases.contactPhrase,
                  style: AppStyles.bottomLinkTextStyle),
              AppSpaces.smallLinkSpace,
              Text(AppPhrases.appointment,
                  style: AppStyles.bottomLinkTextStyle),
              AppSpaces.smallLinkSpace,
            ],
          ),
        ));
  }
}
