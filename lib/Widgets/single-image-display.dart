import 'package:fendi/Models/image-poster.dart';
import 'package:fendi/Widgets/larger-image.dart';
import 'package:flutter/material.dart';

class SingeImageDisplay extends StatelessWidget {
  final ImagePoster poster;
  const SingeImageDisplay(this.poster);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DetailScreen(poster)));
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.zoomIn,
        child: ClipRRect(
          child: Image(
            image: NetworkImage(poster.imagePath),
            width: MediaQuery.of(context).size.width * 0.20,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
