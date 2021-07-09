import 'package:fendi/Models/image-poster.dart';
import 'package:fendi/Utils/utils.dart';
import 'package:fendi/Widgets/larger-image.dart';
import 'package:fendi/constants/constants.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';

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
                  color: HexColor.fromHex(backgroundColor),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 30, bottom: 30, right: 30, left: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RotatedBox(
                              quarterTurns: 3,
                              child: Text(
                                  "${_currentIndex + 1}/${_totalNumberOfImages}",
                                  style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))),
                          InkWell(
                            onTap: () {
                              showDetailsBottomSheet();
                            },
                            child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        width: 1, color: Colors.white)),
                                child: Center(
                                  child: Icon(Icons.more_vert,
                                      color: Colors.white),
                                )),
                          )
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
                  children: [
                    for (MapEntry entry in _imagePosters.asMap().entries)
                      singeImageDisplay(entry.key, entry.value)
                  ]
                  // children: _imagePosters.map((key, ImagePoster item) {
                  //   return singeImageDisplay(key, item);
                  // }).toList()

                  )),
          Positioned(
              top: 40,
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

  Widget singeImageDisplay(key, ImagePoster poster) {
    return VisibilityDetector(
      key: Key(key.toString()),
      onVisibilityChanged: (VisibilityInfo info) {
        if (info.visibleFraction == 1)
          setState(() {
            _currentIndex = key;
            print(_currentIndex);
          });
      },
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DetailScreen(poster)));
        },
        child: MouseRegion(
          cursor: SystemMouseCursors.zoomIn,
          child: ClipRRect(
            child: Image(
              image: NetworkImage(poster.imagePath),
              width: MediaQuery.of(context).size.width * 0.80,
              height: 500,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  List<ImagePoster> initializeImages() {
    _imagePosters = [];
    _imagePosters.add(new ImagePoster(ImagePath.firstImage, "#9d403f"));
    _imagePosters.add(new ImagePoster(ImagePath.secondImage, "#a32c38"));

    _imagePosters.add(new ImagePoster(ImagePath.thirdImage, "#44332e"));
    _imagePosters.add(new ImagePoster(ImagePath.fourthImage, "#865f51"));
    _imagePosters.add(new ImagePoster(ImagePath.fifthImage, "#442927"));
    _imagePosters.add(new ImagePoster(ImagePath.sixthImage, "#e8e6e0"));
    _imagePosters.add(new ImagePoster(ImagePath.seventhImage, "#e9e4de"));
    _imagePosters.add(new ImagePoster(ImagePath.eigthImage, "#b5a192"));
    _imagePosters.add(new ImagePoster(ImagePath.ninethImage, "#845f52"));

    _imagePosters.add(new ImagePoster(ImagePath.tenthImage, "#a67c52"));
    return _imagePosters;
  }

  showDetailsBottomSheet() {
    return showModalBottomSheet(
        context: context,
        builder: (context) => Container(
            height: Utils.screenHeight,
            decoration: new BoxDecoration(
              color: AppColors.white,
            ),
            child: Column(children: [
              SizedBox(
                height: Utils.screenHeight * 0.05,
              ),
              Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close, size: 25)),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(AppPhrases.locator.replaceAll('|', '').toUpperCase(),
                        style: AppStyles.headerTextStyle.copyWith(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w600)),
                    Text(
                        AppPhrases.contactPhrase
                            .replaceAll('|', '')
                            .toUpperCase(),
                        style: AppStyles.headerTextStyle.copyWith(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w600)),
                    Text(AppPhrases.appointment.toUpperCase(),
                        style: AppStyles.headerTextStyle.copyWith(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              )
            ])));
  }
}
