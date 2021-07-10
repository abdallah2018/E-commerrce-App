import 'dart:async';
import 'location_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {

  static const String routeName ='splash_screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    Timer(
        Duration(seconds: 3),
            (){
          FirebaseAuth.instance
              .authStateChanges()
              .listen((User? user) {
            if(user == null){
              print('user_isnot-loggedIn');
              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            }else{
              Navigator.pushReplacementNamed(context, LocationScreen.routeName);
            }
          });
        }
    );
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    const colorizeColors=[
      Colors.white,
      Colors.grey,
    ];

    const colorizeTextStyle = TextStyle(
      fontSize: 30.0,
      fontFamily: 'Horizon',
    );

    return Scaffold(
      backgroundColor: Colors.cyan.shade900,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/logo.png',
            color: Colors.cyan.shade900,
            ),
            SizedBox(height: 10,),
        AnimatedTextKit(
          animatedTexts: [
            ColorizeAnimatedText(
              'BuyOrsell',
              textStyle: colorizeTextStyle,
              colors: colorizeColors,
            ),
          ],
          isRepeatingAnimation: true,
          onTap: () {
            print("Tap Event");
          },
        ),
          ],
        ),
      ),
    );
  }
}
