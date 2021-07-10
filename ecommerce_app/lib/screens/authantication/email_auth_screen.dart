import 'package:ecommerce_app/screens/authantication/password_reset_screen.dart';
import 'package:ecommerce_app/services/emailauth_service.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmailAuthScreen extends StatefulWidget {
  static const String routeName ='email_auth_screen';


  @override
  _EmailAuthScreenState createState() => _EmailAuthScreenState();
}

class _EmailAuthScreenState extends State<EmailAuthScreen> {

  final _formKey = GlobalKey<FormState>();
  bool  _validate = false;
  bool  _loading = false;
  bool  _login = false;
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  EmailAuthanticationService  _service  = EmailAuthanticationService();

  _validateEmail(){
    if(_formKey.currentState!.validate()){
      setState(() {
        _validate = false;
        _loading = true;
      });

      _service.getAdminCredential(_emailController.text,_passwordController.text,_login,_emailController.text)
    .then((value) {
      setState(() {
      _loading = false;
                }
            );
          }
        );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
            'Login',
          style: TextStyle(
            color: Colors.black
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40,),
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.red.shade200,
                child: Icon(
                  CupertinoIcons.person_alt_circle,
                  color: Colors.red,
                  size: 60,
                ),
              ),
              SizedBox(height: 12,),
              Text(
                'Enter to ${_login ?  'Login' :'Register' }',
                style:TextStyle(fontSize: 30,
                    fontWeight: FontWeight.bold
                ) ,
              ),
              SizedBox(height: 10,),
              Text(
                  'Enter Email and password to ${_login ?  'Login' :'Register' }',
                style:TextStyle(
                    color: Colors.grey
                ) ,
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: _emailController,
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
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10.0),
                  labelText: 'Email',
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                obscureText: true,
                controller: _passwordController,
                onChanged: (value){
                  if(_emailController.text.isNotEmpty){
                    if(value.length>3){
                      setState(() {
                        _validate = true;
                      });
                    }else{
                      setState(() {
                        _validate = false;
                      });
                    }
                  }
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10.0),
                  labelText: 'Password',
                  suffixIcon: _validate ? IconButton(
                      icon:Icon(Icons.clear),
                    onPressed: () {
                        _passwordController.clear();
                        setState(() {
                          _validate = false;
                        });
                    },)
                      : null,
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, PasswordResetScreen.routeName);
                  },
                  child: Text(
                    'Forget password',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _login = !_login;
                      });
                    },
                    child: Text(
                      _login  ?'New Account ? ':'Already has an account ?',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],

          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: AbsorbPointer(
            absorbing: _validate ? false : true,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                _validate ? MaterialStateProperty.all(Theme.of(context).primaryColor)
                    : MaterialStateProperty.all(Colors.grey),
              ),
              onPressed: () {
                _validateEmail();
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: _loading ?  SizedBox(
                  height: 24.0,
                  width: 24.0,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
                    :Text(
                  '${_login ?  'Login' :  'Register'}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            ),
          ),
        ),
      ),
    );
  }
}
