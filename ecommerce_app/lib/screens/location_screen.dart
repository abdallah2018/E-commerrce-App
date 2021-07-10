import 'package:ecommerce_app/screens/home_screen.dart';
import 'package:ecommerce_app/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationScreen extends StatefulWidget {

  static const String routeName ='location-screen';


  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  Location location = new Location();
  bool _loading = false;
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;

  Future<LocationData?> getLocation()async{
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    _locationData = await location.getLocation();

    return _locationData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Image.asset('assets/images/location.jpg'),
          SizedBox(height: 20,),
          Text(
            'where do you want \nto buy products ',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          SizedBox(height: 20,),
          Text(
        'To enjoy all that we have to offer you\nwe need to get your location ',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12,
        ),
      ),
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: _loading ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                    ),
                  ): ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).primaryColor),
                    ),
                      onPressed: (){
                      setState(() {
                        _loading = true;
                      });
                        getLocation().then((value){
                          if(value!=null){
                            Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (BuildContext context)=>
                              HomeScreen(_locationData))
                            );
                          }
                        });
                      },
                      icon: Icon(CupertinoIcons.location_fill),
                      label: Padding(
                        padding: const EdgeInsets.only(top: 15.0,bottom: 15.0),
                        child: Text('Around me',
                          style:TextStyle(
                            fontWeight: FontWeight.bold,
                          ) ,),
                      ),
                  ),
                ),
              ],
            ),
          ),
          TextButton(onPressed: (){},
              child: Text(
                'Set location manually',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 18,
                  decoration: TextDecoration.underline,
                ),
              ),
          ),

        ],
      ),
    );
  }
}
