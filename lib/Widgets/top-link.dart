import 'package:fendi/constants/constants.dart';
import 'package:flutter/material.dart';

class TopLinks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 20,
        right: 20,
        child: Row(children: [
          Icon(Icons.vertical_align_bottom, color: Colors.white, size: 18),
          AppSpaces.smallLinkSpace,
          Text(AppPhrases.downloadPhrase.toUpperCase(),
              style: AppStyles.headerTextStyle),
        ]));
  }
}
