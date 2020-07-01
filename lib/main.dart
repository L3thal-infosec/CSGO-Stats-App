
import 'package:flutter/material.dart';
import 'package:csgoapp/pages/splashpage.dart';
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CSGO Stats App',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: SplashPage(),
    );
  }
}