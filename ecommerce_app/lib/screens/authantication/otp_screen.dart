import 'package:ecommerce_app/screens/authantication/phoneauth_screen.dart';
import '../location_screen.dart';
import 'package:ecommerce_app/services/phoneauth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OTPScreen extends StatefulWidget {

  final String number,verId;
  OTPScreen(this.number, this.verId);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {

  bool  _loading = false;
  String error = '';

  PhoneAuthService _service =  PhoneAuthService();

  var _text1 = TextEditingController();
  var _text2 = TextEditingController();
  var _text3 = TextEditingController();
  var _text4 = TextEditingController();
  var _text5 = TextEditingController();
  var _text6 = TextEditingController();

  Future<void>phoneCredential(BuildContext context, String otp)async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    try{
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: widget.verId, smsCode: otp);

      final User? user =(await _auth.signInWithCredential(credential)).user;

      if(user!=null){
        _service.addUser(context,user.uid);

      }else {
        print('login-failed');
        if (mounted) {
          setState(() {
            error = 'login-failed';
          });
        }
      }
    }catch(e){
      print(e.toString());
      if (mounted) {
      error='Invalid-OTP';
    }
    }
  }

  @override
  Widget build(BuildContext context) {

    final node = FocusScope.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text('Login',
        style: TextStyle(color: Colors.black),),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20,  right: 20),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 40,),
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.red.shade200,
              child:Icon(
               CupertinoIcons.person_alt_circle,
               size: 60,
               color: Colors.red,
              ),
            ),
            SizedBox(height: 10,),
            Text('welcome_Back',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25),
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: RichText(
                      text: TextSpan(
                        text: 'We sent a 6-digit code to ',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12),
                        children: [
                          TextSpan(
                            text: widget.number,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 12),

                          ),
                        ],
                      ),

                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PhoneAuthScreen()));

                  },
                    child: Icon(Icons.edit))
              ],
            ),
            SizedBox(height: 12,),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _text1,
                    textInputAction: TextInputAction.next,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value){
                      if(value.length==1){
                        node.nextFocus();                      }
                    },
                  ),
                ),
                SizedBox(height: 10,),
                Expanded(
                  child: TextFormField(
                    controller: _text2,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value){
                      if(value.length==1){
                        node.nextFocus();
                      }
                    },
                  ),
                ),
                SizedBox(height: 10,),
                Expanded(
                  child: TextFormField(
                    controller: _text3,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value){
                      if(value.length==1){
                        node.nextFocus();                      }
                    },
                  ),
                ),
                SizedBox(height: 10,),
                Expanded(
                  child: TextFormField(
                    controller: _text4,
                    textInputAction: TextInputAction.next,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value){
                      if(value.length==1){
                        node.nextFocus();                      }
                    },
                  ),
                ),
                SizedBox(height: 10,),
                Expanded(
                  child: TextFormField(
                    controller: _text5,
                    textAlign: TextAlign.center,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value){
                      if(value.length==1){
                        node.nextFocus();                      }
                    },
                  ),
                ),
                SizedBox(height: 10,),
                Expanded(
                  child: TextFormField(
                    controller: _text6,
                    textAlign: TextAlign.center,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value){
                      if(value.length==1){
                        if(_text1.text.length==1){
                          if(_text2.text.length==1){
                            if(_text3.text.length==1){
                              if(_text4.text.length==1){
                                if(_text5.text.length==1){
                                  String _otp='${_text1.text}${_text2.text}${_text3.text}${_text4.text}${_text5.text}${_text6.text}';
                                  setState(() {
                                    _loading=true;
                                  });
                                  phoneCredential(context, _otp);
                                }
                              }
                            }
                          }
                        }
                      }else{
                        setState(() {
                          _loading=false;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 18,),
            if(_loading)
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 50,
              child:LinearProgressIndicator(
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
              ),
              ),
            ),
            SizedBox(height: 18,),
            Text(error,style: TextStyle(
              color: Colors.red,
              fontSize: 12,
              fontWeight: FontWeight.bold
            ),)
          ],
        ),
      ),
    );
  }
}
