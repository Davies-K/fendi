import 'package:fendi/Models/image-poster.dart';
import 'package:fendi/Utils/utils.dart';
import 'package:fendi/Widgets/bottom-link.dart';
import 'package:fendi/Widgets/rotated-image-display.dart';
import 'package:fendi/Widgets/single-image-display.dart';
import 'package:fendi/Widgets/top-link.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '/constants/constants.dart';

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
    _initializeImages();
    _initializeRotatedImageAnimationController();
    _initializeFlyingInTextAnimationController();
    _totalNumberOfImages = _initializeImages().length;

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
                                    Text(AppPhrases.flyingTextPrefix,
                                        textAlign: TextAlign.center,
                                        style: AppStyles.flyInTextStyle),
                                    Text(AppPhrases.flyingTextSuffix,
                                        textAlign: TextAlign.center,
                                        style: AppStyles.flyInTextStyle),
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
                              Text(AppPhrases.brandName.toUpperCase(),
                                  style: AppStyles.brandTextStyle),
                              Text(AppPhrases.brandLocation.toUpperCase(),
                                  style: AppStyles.brandTextStyle.copyWith(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600)),
                            ])),
                    Positioned(
                        bottom: Utils.screenHeight * 0.05,
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
                                      },
                                      icon: Icon(Icons.west))
                                  : Icon(Icons.west, color: Colors.grey[300]),
                              SizedBox(width: 10),
                              Text(
                                  ' ${_currentIndex + 1}/$_totalNumberOfImages ',
                                  style: GoogleFonts.lato()),
                              SizedBox(width: 10),
                              _showLastIcon
                                  ? IconButton(
                                      onPressed: () {
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
            child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                color: HexColor.fromHex(backgroundColor),
                child: Stack(children: [TopLinks(), BottomLink()])))
      ])),

      //Container with horizontal images and stack piled images
      Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
              child: Container(
                  height: Utils.screenHeight * 0.38,
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
                                  RotatedImagePoster(entry.key, entry.value)
                              ],
                            ),
                          )),
                      Expanded(
                          child: AnimatedList(
                              scrollDirection: Axis.horizontal,
                              controller: _scrollController,
                              key: listKey,
                              initialItemCount: _totalNumberOfImages,
                              itemBuilder: (context, index, animation) {
                                return slideImagePoster(
                                    context, index, animation);
                              }))
                    ],
                  ))))
    ]);
  }

  changeBackgroundColor(String color) {
    backgroundColor = color;
  }

  Widget slideImagePoster(BuildContext context, int index, animation) {
    ImagePoster item = _imagePosters[index];

    return ScaleTransition(
      scale: animation,
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
            child: SingeImageDisplay(item)),
      ),
    );
  }

  // Define the function that scroll to an item
  _scrollToFirstIndex() {
    _scrollController.jumpTo(
      0,
    );
  }

  _scrollToIndex(index) {
    _scrollController
        .animateTo((_width) * (index),
            duration: Duration(milliseconds: 1000), curve: Curves.fastOutSlowIn)
        .then((value) => Future.delayed(const Duration(milliseconds: 0), () {
              _scrollToFirstIndex();
            }));
  }

  Future<void> deleteFirstPost(index) async {
    if (_imagePosters.length > 1) {
      Future.delayed(const Duration(milliseconds: 0), () {
        _scrollToIndex(1);
      });

      listKey.currentState!.removeItem(
          0, (_, animation) => slideImagePoster(context, 0, animation),
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
      _rotatedPosters.insert(lastRotatedIndex, poster);
      _rotatedPosters.length > 0
          ? (_showPreviousIcon = true)
          : (_showPreviousIcon = false);
      _imagePosters.length > 0
          ? (_showLastIcon = true)
          : (_showLastIcon = false);
      setState(() {
        _currentIndex += 1;
      });
      changeBackgroundColor(_imagePosters[0].backgroundColor);
    }
  }

  Future<void> addFirstPost(index) async {
    ImagePoster poster = _rotatedPosters.last;
    listKey.currentState!
        .insertItem(0, duration: const Duration(milliseconds: 500));
    _rotatedPosters.removeAt(_rotatedPosters.length - 1);
    _imagePosters.insert(0, poster);
    _rotatedPosters.length > 0
        ? (_showPreviousIcon = true)
        : (_showPreviousIcon = false);
    _imagePosters.length > 0 ? (_showLastIcon = true) : (_showLastIcon = false);
    setState(() {
      _currentIndex -= 1;
    });
    changeBackgroundColor(_imagePosters[0].backgroundColor);
  }

  List<ImagePoster> _initializeImages() {
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

  _initializeRotatedImageAnimationController() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
  }

  _initializeFlyingInTextAnimationController() {
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
  }
}
