import 'package:ecommerce_app/screens/authantication/email_auth_screen.dart';
import 'package:ecommerce_app/screens/authantication/email_verificatoin_screen.dart';
import 'package:ecommerce_app/screens/authantication/google_auth.dart';
import 'package:ecommerce_app/screens/authantication/phoneauth_screen.dart';
import 'package:ecommerce_app/services/phoneauth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';


class AuthUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 220,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(3.0),
                ),
              ),
                onPressed: (){
                Navigator.pushNamed(context, PhoneAuthScreen.routeName);
                },
                child: Row(
                  children: [
                    Icon(Icons.phone_android_outlined,  color: Colors.black,),
                    SizedBox(width: 8,),
                    Text('continue  with  phone', style:TextStyle(color: Colors.black,)),
                  ],
            )),
          ),
          SignInButton(
              Buttons.Google,
              text: ('Continue with Google'),
              onPressed: ()async{
                User? user = await GoogleAuthantication.signinWithGoogle(context: context);
              if(user != null){
                PhoneAuthService  _authentication=PhoneAuthService();
                _authentication.addUser(context, user.uid);
              }
            }
         ),
          SignInButton(
              Buttons.Facebook,
              text: ('Continue with Facebook'),
              onPressed: (){}
              ),
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, EmailAuthScreen.routeName);
             // Navigator.pushNamed(context, EmailVerificationScreen.routeName);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.white))
                ),
                child: Text(
                  'Login with Email',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
