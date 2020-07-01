import 'package:flutter/material.dart';
import 'dart:async';

import 'package:csgoapp/pages/homepage.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  startSplashTimer() {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigateToHome);
  }

  navigateToHome() {
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(
        builder: (context) => HomePage()
      )
    );
  }

  @override
  void initState() {
    startSplashTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: deviceHeight * 0.3,
            ),
            Container(
              height: 250,
              width: 250,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/csgofinal.gif")
                )
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "CSGO STATS APP",
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 25
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Noobs by Skills, Pros by Heart",
              style: TextStyle(
                color: Colors.white,
                height: 1,
                wordSpacing: 1.5,
                fontSize: 22,
              ),
            )
          ],
        ),
      ),
    );
  }
}