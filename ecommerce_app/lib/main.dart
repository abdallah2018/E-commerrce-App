import 'package:ecommerce_app/screens/authantication/email_auth_screen.dart';
import 'package:ecommerce_app/screens/authantication/email_verificatoin_screen.dart';
import 'package:ecommerce_app/screens/authantication/password_reset_screen.dart';
import 'package:ecommerce_app/screens/authantication/phoneauth_screen.dart';
import 'package:ecommerce_app/screens/home_screen.dart';
import 'package:ecommerce_app/screens/login_screen.dart';
import 'package:ecommerce_app/screens/splash_screen.dart';
import 'package:location/location.dart';
import 'screens/location_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Replace the 3 second delay with your initialization code:
      future: Future.delayed(Duration(seconds: 3)),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
              home: SplashScreen(),
              theme: ThemeData(
                primaryColor: Colors.cyan.shade900,
                fontFamily: 'Herizon'
            ),
          );
        } else {
          // Loading is done, return the app:
          return MaterialApp(
            theme: ThemeData(
              primaryColor: Colors.cyan.shade900,
              fontFamily: 'Herizon'
            ),
            //home: LoginScreen(),
            initialRoute: SplashScreen.routeName,
            routes: {
              SplashScreen.routeName:  (context) =>  SplashScreen(),
              LoginScreen.routeName:  (context) =>  LoginScreen(),
              PhoneAuthScreen.routeName:  (context) =>  PhoneAuthScreen(),
              LocationScreen.routeName:  (context) =>  LocationScreen(),
              HomeScreen.routeName:  (context) =>  HomeScreen(locationData: null,),
              EmailAuthScreen.routeName:  (context) =>  EmailAuthScreen(),
              EmailVerificationScreen.routeName:  (context) =>  EmailVerificationScreen(),
              PasswordResetScreen.routeName:  (context) =>  PasswordResetScreen(),
            },
          );
        }
      },
    );

  }
}

