import 'package:flutter/material.dart';
import 'views/Adam Sorensen/adam_home_view.dart';
import 'views/home_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fendi Collection',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //Replace HomeView with AdamHome for Sorensen's Widget
      home: HomeView(),
    );
  }
}
