import 'package:animate_do/animate_do.dart';
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
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController = new ScrollController();
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  late AnimationController _controller;

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
    });

    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

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
                        SlideInDown(
                          from: 450,

                          duration: Duration(milliseconds: 6600),
                          //infinite: true,
                          child: Container(
                            height: double.infinity,
                            //width: 150,
                            child: RotatedBox(
                                quarterTurns: 3,
                                child: Center(
                                    child: Text("2021 Woman Spring",
                                        textAlign: TextAlign.center,
                                        //overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.lato(
                                            color: Color.fromRGBO(
                                                154, 116, 84, 0.6),
                                            fontSize: 100,
                                            fontWeight: FontWeight.w500)))),
                          ),
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
                        bottom: 200,
                        right: 20,
                        child: Container(
                          width: 150,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _showPreviousIcon
                                  ? IconButton(
                                      onPressed: () {
                                        print('tapped');
                                        ImagePoster poster =
                                            _rotatedPosters.last;
                                        listKey.currentState!.insertItem(0,
                                            duration: const Duration(
                                                milliseconds: 550));

                                        // _imagePosters.add(poster);

                                        addFirstPost(0);
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
                                        _playAnimation();
                                        listKey.currentState!.removeItem(
                                            0,
                                            (_, animation) =>
                                                slideIt(context, 0, animation),
                                            duration: const Duration(
                                                milliseconds: 550));
                                        //_scrollToIndex(2);
                                        deleteFirstPost(0);
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
            child: Container(
                color: AppColors.primaryColor,
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
                      bottom: 200,
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
                  height: 400,
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
                              key: listKey,
                              initialItemCount: _totalNumberOfImages,
                              itemBuilder: (context, index, animation) {
                                return slideIt(context, index, animation);
                              }))
                    ],
                  ))))
    ]);
  }

  Widget slideIt(BuildContext context, int index, animation) {
    ImagePoster item = _imagePosters[index];

    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-40, 0),
              end: Offset(0, 0),
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCirc,
              reverseCurve: Curves.easeOutCirc,
            )),
            child: singeImageDisplay(item)),
      ),
    );
  }

  // Define the function that scroll to an item
  Future<void> _scrollToIndex(index) async {
    _scrollController.animateTo(_width * index,
        duration: Duration(milliseconds: 600), curve: Curves.easeIn);
  }

  Future<void> deleteFirstPost(index) async {
    int lastRotatedIndex;
    _rotatedPosters.length < 1
        ? (lastRotatedIndex = 0)
        : (lastRotatedIndex = _rotatedPosters.length);
    ImagePoster poster = _imagePosters.first;

    //reset animation
    _controller.reset();
    _controller.forward();

    setState(() {
      _imagePosters.removeAt(index);
      _rotatedPosters.insert(lastRotatedIndex, poster);
      _rotatedPosters.length > 0
          ? (_showPreviousIcon = true)
          : (_showPreviousIcon = false);
      _imagePosters.length > 0
          ? (_showLastIcon = true)
          : (_showLastIcon = false);
      _currentIndex += 1;
    });
  }

  Future<void> addFirstPost(index) async {
    ImagePoster poster = _rotatedPosters.last;

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
  }

  List<ImagePoster> initializeImages() {
    _imagePosters = [];
    _imagePosters.add(new ImagePoster(
        "https://images.www.fendi.com/static/digitallookbook/woman-spring-summer-2021/assets/listing/images/236a07f777d662b78b9c23337194ff36.jpg",
        "red"));
    _imagePosters.add(new ImagePoster(
        "https://images.www.fendi.com/static/digitallookbook/woman-spring-summer-2021/assets/listing/images/a0bd071d00d0d68e4ce497d21af2e462.jpg",
        "red"));
    _imagePosters.add(new ImagePoster(
        "https://images.www.fendi.com/static/digitallookbook/woman-spring-summer-2021/assets/listing/images/36ad587a3e530c02cd26936ac55c1def.jpg",
        "red"));
    _imagePosters.add(new ImagePoster(
        "https://images.www.fendi.com/static/digitallookbook/woman-spring-summer-2021/assets/listing/images/2677bf655081c90cfa01a60b52f91399.jpg",
        "red"));

    _imagePosters.add(new ImagePoster(
        "https://images.www.fendi.com/static/digitallookbook/woman-spring-summer-2021/assets/listing/images/306e07a7380a27fe09cc63c3c304bc9a.jpg",
        "red"));
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
    return FadeTransition(
      opacity: _controller,
      child: Transform.rotate(
        angle: ((index == 0) || index % 2 == 0) ? math.pi / 50 : -math.pi / 50,
        child: ClipRRect(
          child: Image(
            image: NetworkImage(poster.imagePath),
            width: MediaQuery.of(context).size.width * 0.13,
            height: 300,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class ImagePoster {
  final String imagePath;
  final String backgroundColor;

  ImagePoster(this.imagePath, this.backgroundColor);
}
