import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:smartfoodappwithadminpanel/screens/home/home_screen.dart';
import 'package:smartfoodappwithadminpanel/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //TODO initState
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), homeScreen);
  }

  // Callback function
  void homeScreen() {
    //TODO Navigator
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => OpenWelcomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Image(image: AssetImage("assets/smart.png")),
            ),
          )
        ],
      ),
    );
  }
}
