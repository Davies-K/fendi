import 'package:fendi/constants/Classes/image_poster.dart';
import 'package:fendi/constants/constants.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeMobileView extends StatefulWidget {
  @override
  _HomeMobileViewState createState() => _HomeMobileViewState();
}

class _HomeMobileViewState extends State<HomeMobileView>
    with SingleTickerProviderStateMixin {
  int _totalNumberOfImages = 0;
  int _currentIndex = 0;
  List<ImagePoster> _imagePosters = [];

  late AnimationController _animController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    // TODO: implement initState
    initializeImages();
    setState(() {
      _totalNumberOfImages = initializeImages().length;
      //backgroundColor = _imagePosters[0].backgroundColor;
    });

    _animController = AnimationController(
      duration: const Duration(seconds: 40),
      vsync: this,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animController.reset();
        } else if (status == AnimationStatus.dismissed) {
          _animController.forward();
        }
      });
    _animController.forward();
    _animation = Tween<Offset>(
      begin: const Offset(0, -1.0),
      end: const Offset(0, 1.4),
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.linear,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Flex(direction: Axis.horizontal, children: [
      //left side of phone
      Expanded(
        flex: 1,
        child: Stack(children: [
          Container(
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: SlideTransition(
                  transformHitTests: true,
                  textDirection: TextDirection.ltr,
                  position: _animation,
                  child: RotatedBox(
                      quarterTurns: 3,
                      child: Container(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Text("2021 Woman Spring",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lato(
                                    color: Color.fromRGBO(154, 116, 84, 0.5),
                                    fontSize: 70,
                                    fontWeight: FontWeight.w300)),
                            Text("/Summer",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lato(
                                    color: Color.fromRGBO(154, 116, 84, 0.5),
                                    fontSize: 70,
                                    fontWeight: FontWeight.w300)),
                          ],
                        ),
                      )),
                ),
              )),
          Positioned(
              bottom: 0,
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  //width: double.infinity,
                  color: HexColor(backgroundColor),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 30, bottom: 30, right: 30, left: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RotatedBox(
                              quarterTurns: 3,
                              child: Text("0/50",
                                  style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))),
                          Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      width: 1, color: Colors.white)),
                              child: Center(
                                child:
                                    Icon(Icons.more_vert, color: Colors.white),
                              ))
                        ]),
                  ))),
        ]),
      ),

      //Right Side
      Expanded(
        flex: 4,
        child: Stack(children: [
          Container(
              height: MediaQuery.of(context).size.height,
              // width: MediaQuery.of(context).size.width,
              child: ListView(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.20),
                  scrollDirection: Axis.vertical,
                  children: _imagePosters.map((ImagePoster item) {
                    return singeImageDisplay(item);
                  }).toList())),
          Positioned(
              top: 50,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.750,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.home, color: Colors.transparent),
                      Column(crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment:
                          //     MainAxisAlignment.spaceAround,
                          children: [
                            Text('FENDI',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold)),
                            Text('ROMA',
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w600)),
                          ]),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            CupertinoIcons.arrow_down_to_line,
                            size: 30,
                            color: Colors.black,
                          ))
                    ]),
              ))
        ]),
      )
    ]);
  }

  Widget singeImageDisplay(ImagePoster poster) {
    return ClipRRect(
      child: Image(
        image: NetworkImage(poster.imagePath),
        width: MediaQuery.of(context).size.width * 0.80,
        height: 500,
        fit: BoxFit.cover,
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
    _imagePosters.add(new ImagePoster(
        "https://images.www.fendi.com/static/digitallookbook/woman-spring-summer-2021/assets/listing/images/36ad587a3e530c02cd26936ac55c1def.jpg",
        "#e8e6e0"));
    _imagePosters.add(new ImagePoster(
        "https://images.www.fendi.com/static/digitallookbook/woman-spring-summer-2021/assets/listing/images/a0bd071d00d0d68e4ce497d21af2e462.jpg",
        "#e9e4de"));
    _imagePosters.add(new ImagePoster(
        "https://images.www.fendi.com/static/digitallookbook/woman-spring-summer-2021/assets/listing/images/236a07f777d662b78b9c23337194ff36.jpg",
        "#b5a192"));
    _imagePosters.add(new ImagePoster(
        "https://images.www.fendi.com/static/digitallookbook/woman-spring-summer-2021/assets/listing/images/2677bf655081c90cfa01a60b52f91399.jpg",
        "#845f52"));
    _imagePosters.add(new ImagePoster(
        "https://images.www.fendi.com/static/digitallookbook/woman-spring-summer-2021/assets/listing/images/306e07a7380a27fe09cc63c3c304bc9a.jpg",
        "#ac845d"));
    _imagePosters.add(new ImagePoster(
        "https://images.www.fendi.com/static/digitallookbook/woman-spring-summer-2021/assets/listing/images/e7d8ace0086eff70371504526f933827.jpg",
        "#a67c52"));
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
