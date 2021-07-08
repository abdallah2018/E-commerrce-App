import 'package:ecommerce_app/widgets/auth_ui.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatelessWidget {
  static const String routeName ='login_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan.shade900,
      body:Column(
        children: [
          Expanded(
              child:
              Container(
                width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Column(
                    children: [
                        SizedBox(
                          height: 100.0,
                      ),
                        Image.asset(
                          'assets/images/logo.png',
                          color: Colors.cyan.shade900,
                        ),
                      SizedBox(height: 10,),
                      Text('data',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.cyan.shade900,

                        ),
                      ),
                  ],
            ),
          )),
          Expanded(child: AuthUi()),
          Text(
              'if you continue , you are accepting\n Terms and conditions  and privacy policy',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
