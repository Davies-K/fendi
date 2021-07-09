import 'package:fendi/Models/image-poster.dart';
import 'package:fendi/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class DetailScreen extends StatelessWidget {
  final ImagePoster imagePoster;
  const DetailScreen(this.imagePoster);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          color: Colors.white,
          child: InteractiveViewer(
            child: Center(
              child: Image(
                image: NetworkImage(imagePoster.imagePath),
                height: Utils.screenHeight,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
            top: 20,
            right: 20,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.close, size: 35),
            )),
        Positioned(
            bottom: 20,
            right: 20,
            child: IconButton(
              onPressed: () {},
              icon: Icon(FeatherIcons.zoomIn, size: 35),
            ))
      ]),
    );
  }
}
