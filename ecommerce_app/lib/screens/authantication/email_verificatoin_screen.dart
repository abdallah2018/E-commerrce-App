import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_mail_app/open_mail_app.dart';

import '../location_screen.dart';

class EmailVerificationScreen extends StatelessWidget {

  static const String routeName ='EmailVerification_Screen';

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
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.start ,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'EmailVerification',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(
                  'check your email',
                style: TextStyle(
                    color: Colors.grey,
              ),
              ),
              SizedBox(height: 20.0,),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                      ),
                      child: Text('Verify Email'),
                      onPressed: () async {

                        var result = await OpenMailApp.openMailApp();

                        // If no mail apps found, show error
                        if (!result.didOpen && !result.canOpen) {
                        showNoMailAppsDialog(context);

                        // iOS: if multiple mail apps found, show dialog to select.
                        // There is no native intent/default app system in iOS so
                        // you have to do it yourself.
                        } else if (!result.didOpen && result.canOpen) {
                        showDialog(
                        context: context,
                        builder: (_) {
                        return MailAppPickerDialog(
                        mailApps: result.options,);
                          },
                      );
                  }
                        Navigator.pushNamed(context, LocationScreen.routeName);
                },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }




}
