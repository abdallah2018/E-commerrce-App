import 'package:ecommerce_app/screens/authantication/email_auth_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_mail_app/open_mail_app.dart';

import '../location_screen.dart';

class PasswordResetScreen extends StatelessWidget {

  static const String routeName ='passwordReset_Screen';

  void showNoMailAppsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Open Mail App"),
          content: Text("No mail apps installed"),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {

    var _emailController = TextEditingController();
    var _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.start ,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.lock,color: Theme.of(context).primaryColor,size: 75.0,),
              SizedBox(height: 10.0,),
              Text(
                'Forget\n password ?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28.0,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(height: 10.0,),
              Text(
                'Enter your email , \n We will send a link to reset your password ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 10.0,),
              TextFormField(
                controller: _emailController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10.0),
                  labelText: 'Registered Email',
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                validator: (value){
                  final bool isValid = EmailValidator.validate(_emailController.text);
                  if(value==null  || value.isEmpty){
                    return  'Enter Email';
                  }
                  if(value.isNotEmpty  && isValid == false){
                    return  'Enter a valid Email';
                  }
                  return  null;
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).primaryColor,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Send',),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            FirebaseAuth.instance.sendPasswordResetEmail(
                email: _emailController.text)
                .then((value) =>
                Navigator.pushReplacementNamed(
                    context, EmailAuthScreen.routeName));
          }
        },
      ),
    );
  }




}
