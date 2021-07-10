import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/screens/authantication/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/location_screen.dart';

class PhoneAuthService{

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(context,uid)async{

    final QuerySnapshot result = await users.where('uid',isEqualTo: uid).get();
    List<DocumentSnapshot>  document = result.docs;

    if(document.length>0){
      Navigator.pushReplacementNamed(context, LocationScreen.routeName);
    }else{

    return users.doc(user!.uid)
        .set({
      'uid':user!.uid,
      'mobile':user!.phoneNumber,
      'email':user!.email,
        })
          .then((value) => Navigator.pushReplacementNamed(context, LocationScreen.routeName));
        //.catchError(onError)=>print("failed to add user $onError");
  }
  }

  Future<void> verifyPhoneNumber(BuildContext context , number) async {
    final PhoneVerificationCompleted  verificationCompleted =
    (PhoneAuthCredential credential)  async {
      await auth.signInWithCredential(credential);
    };

    final PhoneVerificationFailed verificationFailed = (FirebaseAuthException e){
      if(e.code == 'invalid-phone-number'){
        print('The provided phone number  is  not valid');
      }
      print('The error code is ${e.code}');
    };

    final PhoneCodeSent codeSent  = (String verId , int resendToken)  async {

     Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPScreen(number,verId)));
    } as PhoneCodeSent;

    try{
      auth.verifyPhoneNumber(
          phoneNumber: number,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          timeout: const Duration(seconds: 60),
          codeAutoRetrievalTimeout: (String verificationId){
            print(verificationId);
          });
    }catch(e){
      print('The error code is ${e.toString()}');
    }

  }



}