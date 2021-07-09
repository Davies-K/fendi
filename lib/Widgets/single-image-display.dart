import 'package:fendi/Models/image-poster.dart';
import 'package:flutter/material.dart';

class SingeImageDisplay extends StatelessWidget {
  final ImagePoster poster;
  const SingeImageDisplay(this.poster);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Image(
        image: NetworkImage(poster.imagePath),
        width: MediaQuery.of(context).size.width * 0.20,
        fit: BoxFit.cover,
      ),
    );
  }
}
