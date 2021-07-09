import 'package:fendi/Models/image-poster.dart';
import 'package:fendi/constants/constants.dart';
import 'package:flutter/material.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

class AdamDesktopView extends StatefulWidget {
  @override
  _AdamDesktopViewState createState() => _AdamDesktopViewState();
}

class _AdamDesktopViewState extends State<AdamDesktopView> {
  List<ImagePoster> _imagePosters = [];
  bool _nexthovering = false;

  void _mouseEnter(bool hover) {
    setState(() {
      _nexthovering = hover;
    });
  }

  @override
  void initState() {
    initializeImages();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: HexColor(backgroundColor),
        child: Stack(
          children: [
            Positioned(
                top: 20,
                left: 50,
                right: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon:
                          Icon(Icons.vertical_distribute, color: Colors.white),
                    ),
                    Text('ADAM SORENSEN',
                        style: TextStyle(
                            fontSize: 22,
                            letterSpacing: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.w400)),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(FeatherIcons.instagram, color: Colors.white),
                    ),
                  ],
                )),
            Center(
                child: Padding(
              padding: EdgeInsets.only(right: 50.0, left: 50.0),
              child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: 500,
                  //color: Colors.red,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("01",
                                style: GoogleFonts.nunito(
                                    fontSize: 11, color: Colors.white)),
                            SizedBox(height: 5),
                            RotatedBox(
                              quarterTurns: 3,
                              child: Container(
                                width: 120,
                                height: 2,
                                child: LinearProgressIndicator(
                                    //leaner progress bar
                                    value: 20.0,
                                    backgroundColor: Colors.grey,
                                    color: Colors.white),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text("06",
                                style: GoogleFonts.nunito(
                                    fontSize: 11, color: Colors.white)),
                          ],
                        ),

                        //stacked Cards
                        Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            //height: 400,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // AnimatedSwitcher(
                                //   duration: const Duration(milliseconds: 500),
                                //   transitionBuilder: (Widget child,
                                //       Animation<double> animation) {
                                //     return ScaleTransition(
                                //         child: child, scale: animation);
                                //   },
                                //   child: Text(
                                //     '$_count',
                                //     // This key causes the AnimatedSwitcher to interpret this as a "new"
                                //     // child each time the count changes, so that it will begin its animation
                                //     // when the count changes.
                                //     key: ValueKey<int>(_count),
                                //     style:
                                //         Theme.of(context).textTheme.headline4,
                                //   ),
                                // ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  //height: 400,
                                  child: Center(
                                    child: Stack(
                                      children: [
                                        for (MapEntry entry
                                            in _imagePosters.asMap().entries)
                                          rotatedImageDisplay(
                                              entry.key, entry.value)
                                      ],
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Icons.horizontal_rule,
                                        color: Colors.white),
                                    Text("NEXT",
                                        style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                              ],
                            )),

                        RotatedBox(
                          quarterTurns: 3,
                          child: Container(
                              width: 100,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all(
                                      width: 1, color: Colors.white))),
                        )
                      ])),
            )),
            Positioned(
                bottom: 50,
                left: MediaQuery.of(context).size.width * 0.1,
                right: MediaQuery.of(context).size.width * 0.1,
                child: Container(
                  alignment: Alignment.center,
                  child: Center(
                    child: Text("Portraits",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.josefinSlab(
                            fontSize: 170,
                            fontWeight: FontWeight.w500,
                            color: Colors.white38)
                        // style: TextStyle(
                        //     fontSize: 150,
                        //     fontWeight: FontWeight.w500,
                        //     color: Colors.white38)

                        ),
                  ),
                ))
          ],
        ));
  }

  Widget rotatedImageDisplay(int index, ImagePoster poster) {
    return GestureDetector(
      key: ValueKey<int>(index),
      onTap: () {
        // _imagePosters.removeAt(4);
        // setState(() {
        //   _imagePosters;
        // });
      },
      child: AnimatedPositioned(
        duration: Duration(milliseconds: 500),
        child: Transform.rotate(
          angle: ((index == 0) || index % 2 == 0)
              ? (math.pi - (5 * index)) / 80
              : (-math.pi + (5 * index)) / 80,
          child: ClipRRect(
            child: Image(
              image: NetworkImage(poster.imagePath),
              width: MediaQuery.of(context).size.width * 0.15,
              height: 400,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  List<ImagePoster> initializeImages() {
    _imagePosters = [];
    _imagePosters.add(new ImagePoster(
        "https://images.www.fendi.com/static/digitallookbook/woman-spring-summer-2021/assets/listing/images/833f7d2172b444c7d052c2527c320e3b.jpg",
        "#9d403f"));
    _imagePosters.add(new ImagePoster(
        "https://images.www.fendi.com/static/digitallookbook/woman-spring-summer-2021/assets/listing/images/1962c4a774c5e7f95d887840e2f4d020.jpg",
        "#a32c38"));

    _imagePosters.add(new ImagePoster(
        "https://images.www.fendi.com/static/digitallookbook/woman-spring-summer-2021/assets/listing/images/c296a19d32371554094925b67c14c68b.jpg",
        "#44332e"));
    _imagePosters.add(new ImagePoster(
        "https://images.www.fendi.com/static/digitallookbook/woman-spring-summer-2021/assets/listing/images/768a680271498dbb305430e936b639bd.jpg",
        "#865f51"));
    _imagePosters.add(new ImagePoster(
        "https://images.www.fendi.com/static/digitallookbook/woman-spring-summer-2021/assets/listing/images/2788088d04658a98e4c6c7e4a3a3c730.jpg",
        "#442927"));

    return _imagePosters;
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
