import 'package:fendi/Models/image-poster.dart';
import 'package:fendi/Widgets/single-image-display.dart';
import 'package:flutter/material.dart';

class SlideImagePoster extends StatelessWidget {
  final BuildContext context;
  final ImagePoster imagePoster;
  final Animation<double> animation;
  const SlideImagePoster(this.context, this.imagePoster, this.animation);

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: this.animation,
      child: FadeTransition(
        opacity: animation,
        child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-40, 0),
              end: Offset(0, 0),
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.decelerate,
              reverseCurve: Curves.decelerate,
            )),
            child: SingeImageDisplay(imagePoster)),
      ),
    );
  }
}
