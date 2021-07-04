import 'package:fendi/constants/Classes/image_poster.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '/constants/constants.dart';
import 'dart:math' as math;

class HomeDesktopView extends StatefulWidget {
  @override
  _HomeDesktopViewState createState() => _HomeDesktopViewState();
}

class _HomeDesktopViewState extends State<HomeDesktopView>
    with TickerProviderStateMixin {
  ScrollController _scrollController = new ScrollController();
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  late AnimationController _controller;

  late AnimationController _animController;
  late Animation<Offset> _animation;

  bool _showPreviousIcon = false;
  bool _showLastIcon = true;

  List<ImagePoster> _imagePosters = [];
  List<ImagePoster> _rotatedPosters = [];

  List<ImagePoster> _items = [];

  int _totalNumberOfImages = 0;
  int _currentIndex = 0;

  double _width = Get.width * 0.20;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    initializeImages();
    setState(() {
      _totalNumberOfImages = initializeImages().length;
      //backgroundColor = _imagePosters[0].backgroundColor;
    });

    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

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

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          child: Row(children: [
        Expanded(
            flex: 1,
            child: Container(
                color: AppColors.secondaryColor,
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SlideTransition(
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
                                            color: Color.fromRGBO(
                                                154, 116, 84, 0.5),
                                            fontSize: 100,
                                            fontWeight: FontWeight.w300)),
                                    Text("/Summer Wear",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.lato(
                                            color: Color.fromRGBO(
                                                154, 116, 84, 0.5),
                                            fontSize: 100,
                                            fontWeight: FontWeight.w300)),
                                  ],
                                ),
                              )),
                        ),
                        SizedBox(width: 200)
                      ],
                    ),
                    Positioned(
                        top: 20,
                        left: 20,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('FENDI',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold)),
                              Text('ROMA',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600)),
                            ])),
                    Positioned(
                        bottom: 150,
                        right: 20,
                        child: Container(
                          width: 150,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _showPreviousIcon
                                  ? IconButton(
                                      onPressed: () {
                                        addFirstPost(0);

                                        // _imagePosters.add(poster);
                                      },
                                      icon: Icon(Icons.west))
                                  : Icon(Icons.west, color: Colors.grey[300]),
                              SizedBox(width: 10),
                              Text(' ${_currentIndex}/$_totalNumberOfImages ',
                                  style: GoogleFonts.lato()),
                              SizedBox(width: 10),
                              _showLastIcon
                                  ? IconButton(
                                      onPressed: () {
                                        deleteFirstPost(0);
                                        //_playAnimation();

                                        //_scrollToIndex(2);
                                      },
                                      icon: Icon(Icons.east))
                                  : Icon(Icons.east, color: Colors.grey[300])
                            ],
                          ),
                        ))
                  ],
                ))),
        Expanded(
            flex: 1,
            child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                color: HexColor(backgroundColor),
                child: Stack(children: [
                  Positioned(
                      top: 20,
                      right: 20,
                      child: Row(children: [
                        Icon(Icons.vertical_align_bottom,
                            color: Colors.white, size: 18),
                        SizedBox(width: 5),
                        Text(' DOWNLOAD THE CATALOGUE',
                            style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600)),
                      ])),
                  Positioned(
                      bottom: 150,
                      right: 0,
                      child: Container(
                        //width: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(' Store Locator |',
                                style: GoogleFonts.lato(color: Colors.white)),
                            SizedBox(width: 5),
                            Text(' Contact Us |',
                                style: GoogleFonts.lato(color: Colors.white)),
                            SizedBox(width: 5),
                            Text(' Book An appointment',
                                style: GoogleFonts.lato(color: Colors.white)),
                            SizedBox(width: 5),
                          ],
                        ),
                      ))
                ])))
      ])),

      //Container with horizontal images and stack piled images
      Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
              child: Container(
                  height: 500,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Center(
                            child: Stack(
                              children: [
                                for (MapEntry entry
                                    in _rotatedPosters.asMap().entries)
                                  rotatedImageDisplay(entry.key, entry.value)
                              ],
                            ),
                          )),

                      //right middle container
                      // Expanded(
                      //     child: ListView(
                      //         scrollDirection: Axis.horizontal,
                      //         controller: _scrollController,
                      //         children: _imagePosters.map((ImagePoster item) {
                      //           return singeImageDisplay(item);
                      //         }).toList()))
                      Expanded(
                          child: AnimatedList(
                              scrollDirection: Axis.horizontal,
                              controller: _scrollController,
                              key: listKey,
                              initialItemCount: _totalNumberOfImages,
                              itemBuilder: (context, index, animation) {
                                return slideIt(context, index, animation);
                              }))
                    ],
                  ))))
    ]);
  }

  changeBackgroundColor(String color) {
    setState(() {
      backgroundColor = color;
    });
  }

  Widget slideIt(BuildContext context, int index, animation) {
    ImagePoster item = _imagePosters[index];

    return ScaleTransition(
      scale: animation,
      child: FadeTransition(
        opacity: animation,
        child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-40, -5),
              end: Offset(0, 0),
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.decelerate,
              reverseCurve: Curves.decelerate,
            )),
            child: singeImageDisplay(item)),
      ),
    );
  }

  // Define the function that scroll to an item
  _scrollToIndex(index) {
    _scrollController.animateTo(_width * (index),
        duration: Duration(milliseconds: 600), curve: Curves.fastOutSlowIn);
  }

  Future<void> deleteFirstPost(index) async {
    _scrollToIndex(20);

    listKey.currentState!.removeItem(
        0, (_, animation) => slideIt(context, 0, animation),
        duration: const Duration(milliseconds: 1000));
    int lastRotatedIndex;
    _rotatedPosters.length < 1
        ? (lastRotatedIndex = 0)
        : (lastRotatedIndex = _rotatedPosters.length);
    ImagePoster poster = _imagePosters.first;
    _imagePosters.removeAt(index);
    //reset animation
    _controller.reset();
    _controller.forward();

    setState(() {
      _rotatedPosters.insert(lastRotatedIndex, poster);
      _rotatedPosters.length > 0
          ? (_showPreviousIcon = true)
          : (_showPreviousIcon = false);
      _imagePosters.length > 0
          ? (_showLastIcon = true)
          : (_showLastIcon = false);
      _currentIndex += 1;
      //_scrollToIndex(0);
    });

    changeBackgroundColor(_imagePosters[0].backgroundColor);
    //_scrollToIndex(0);
  }

  Future<void> addFirstPost(index) async {
    ImagePoster poster = _rotatedPosters.last;
    listKey.currentState!
        .insertItem(0, duration: const Duration(milliseconds: 500));
    setState(() {
      _rotatedPosters.removeAt(_rotatedPosters.length - 1);
      _imagePosters.insert(0, poster);
      _rotatedPosters.length > 0
          ? (_showPreviousIcon = true)
          : (_showPreviousIcon = false);
      _imagePosters.length > 0
          ? (_showLastIcon = true)
          : (_showLastIcon = false);
      _currentIndex -= 1;
    });
    changeBackgroundColor(_imagePosters[0].backgroundColor);
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
        "https://images.www.fendi.com/static/digitallookbook/woman-spring-summer-2021/assets/listing/images/e7d8ace0086eff70371504526f933827.jpg",
        "#a67c52"));
    return _imagePosters;
  }

  Widget singeImageDisplay(ImagePoster poster) {
    return ClipRRect(
      child: Image(
        image: NetworkImage(poster.imagePath),
        width: MediaQuery.of(context).size.width * 0.20,
        fit: BoxFit.cover,
      ),
    );
  }

  Future<void> _playAnimation() async {
    try {
      await _controller.forward().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because it was disposed of
    }
  }

  Widget rotatedImageDisplay(int index, ImagePoster poster) {
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
