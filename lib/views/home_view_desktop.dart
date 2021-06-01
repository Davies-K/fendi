import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/constants/constants.dart';

class HomeDesktopView extends StatefulWidget {
  @override
  _HomeDesktopViewState createState() => _HomeDesktopViewState();
}

class _HomeDesktopViewState extends State<HomeDesktopView> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                                          color:
                                              Color.fromRGBO(154, 116, 84, 0.6),
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
                                    fontSize: 30, fontWeight: FontWeight.bold)),
                            Text('ROMA',
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w600)),
                          ])),
                  Positioned(
                      bottom: 200,
                      right: 20,
                      child: Container(
                        width: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.west),
                            SizedBox(width: 10),
                            Text(' 16/50 ', style: GoogleFonts.lato()),
                            SizedBox(width: 10),
                            Icon(Icons.east),
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
    ]));
  }
}
