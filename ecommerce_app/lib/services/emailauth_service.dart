

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/screens/authantication/email_verificatoin_screen.dart';
import 'package:ecommerce_app/screens/location_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailAuthanticationService {

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<DocumentSnapshot> getAdminCredential(email,password,isLog,context) async {
    final DocumentSnapshot _result = await users.doc(email).get();

    if(isLog){
      emailLogin(email,password,context);
    }else{
      if(_result.exists){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('An account already  exists with this email'),
          )
        );
      }else{
        emailRegister(email,password,context);
      }
    }


    return  _result;
  }

   emailLogin(email, password,context) async{

     try {
       UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
           email: email,
           password: password,
       );
       if(userCredential.user!.uid!=null){
         Navigator.pushReplacementNamed(context, LocationScreen.routeName);
       }
     } on FirebaseAuthException catch (e) {
       if (e.code == 'user-not-found') {
         ScaffoldMessenger.of(context).showSnackBar(
             const SnackBar(
               content: Text('No user found for that email.'),
             )
         );
         print('No user found for that email.');
       }
       else if (e.code == 'wrong-password') {
         ScaffoldMessenger.of(context).showSnackBar(
             const SnackBar(
               content: Text('Wrong password provided for that user.'),
             )
         );
         print('Wrong password provided for that user.');

       }
     }
   }

   emailRegister(email, password,context) async{
     try {
       UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
           email: email,
           password: password,
       );
       if(userCredential.user!.uid != null){
         return users.doc(userCredential.user!.email).set({
           'uid':userCredential.user!.uid,
           'mobile':null,
           'email':userCredential.user!.email,
         }).then((value) async {
           await userCredential.user!.sendEmailVerification()
               .then((value) {
             Navigator.pushReplacementNamed(context, EmailVerificationScreen.routeName);
           });
           //Navigator.pushReplacementNamed(context, LocationScreen.routeName);
          });
           // .catchError(onError){};
       }
     } on FirebaseAuthException catch (e) {
       if (e.code == 'weak-password') {
         ScaffoldMessenger.of(context).showSnackBar(
             const SnackBar(
               content: Text('The password provided is too weak.'),
             )
         );
         print('The password provided is too weak.');
       }
       else if (e.code == 'email-already-in-use') {
         ScaffoldMessenger.of(context).showSnackBar(
             const SnackBar(
               content: Text('The account already exists for that email.'),
             )
         );
         print('The account already exists for that email.');
       }
     } catch (e) {
       ScaffoldMessenger.of(context).showSnackBar(
           const SnackBar(
             content: Text('Error occurred.'),
           )
       );
       print(e);
     }
   }

}