import 'package:ecommerce_app/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';

class HomeScreen extends StatefulWidget {

  static const String routeName ='home_screen';
  late final LocationData  locationData;

  HomeScreen({ required this.locationData});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String address = 'India';

  Future<String>getAddress() async {
    final coordinates = new Coordinates(widget.locationData.latitude, widget.locationData.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    setState(() {
      address = first.addressLine;
    });

    return first.addressLine;
  }

  @override
  void initState() {
    getAddress();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.white),
        automaticallyImplyLeading: false,
        title: InkWell(
          onTap: (){},
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0,bottom:8.0 ),
              child: Row(
                children: [
                  Icon(CupertinoIcons.location_solid,color: Colors.black,size: 18,),
                  Flexible(
                    child: Text(address,
                      style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                  ),
                  Icon(Icons.arrow_downward_outlined,color: Colors.black,size: 18,),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child:  ElevatedButton(
          onPressed: () {
            FirebaseAuth.instance
                .signOut()
                .then((value) => Navigator.pushReplacementNamed(context, LoginScreen.routeName));
          },
        child: Text('Sign Out'),)
      ),
    );
  }
}
