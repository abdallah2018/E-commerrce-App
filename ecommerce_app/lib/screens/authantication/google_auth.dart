import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthantication{

  static SnackBar customSnackBar({required String content}){
    return SnackBar(
        backgroundColor: Colors.black,
        content:Text(
          content,
          style: TextStyle(
            color: Colors.redAccent,
            letterSpacing: 0.5
          ),
        ),
    );
  }

  static Future<User?>signinWithGoogle({required BuildContext context}) async{

    FirebaseAuth auth = FirebaseAuth.instance;
    User ?user ;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken
      );
      // Getting users credential
      try {
        final UserCredential result = await auth.signInWithCredential(authCredential);
        User? user = result.user;
        if (result != null) {
        //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
        }  // if result not null we simply call the MaterialpageRoute,
      }on FirebaseException catch (e) {
        if(e.code=='account-exists-with-different-credential'){
          ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(content: 'Error signing-out. try again',)
          );
        }else if(e.code=='invalid-credintial'){
          ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(content: 'invalid-credintial',)
          );
        }
      }catch (e){
        ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(content: 'login-failed',)
        );
      }
  }

return user;
  }





}