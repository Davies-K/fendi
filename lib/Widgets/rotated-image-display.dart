import 'package:fendi/Models/image-poster.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class RotatedImagePoster extends StatelessWidget {
  final int index;
  final ImagePoster poster;
  const RotatedImagePoster(this.index, this.poster);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: ((index == 0) || index % 2 == 0) ? math.pi / 50 : -math.pi / 50,
      child: ClipRRect(
        child: Image(
          image: NetworkImage(poster.imagePath),
          width: MediaQuery.of(context).size.width * 0.15,
          height: 400,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
