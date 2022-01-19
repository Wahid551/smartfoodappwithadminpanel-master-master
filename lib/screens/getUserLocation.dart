import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:smartfoodappwithadminpanel/screens/hotels.dart';

// import 'package:smartfoodappwithadminpanel/screens/hotels.dart';

class GetUserLocation extends StatefulWidget {
  const GetUserLocation({Key? key}) : super(key: key);

  @override
  _GetUserLocationState createState() => _GetUserLocationState();
}

class _GetUserLocationState extends State<GetUserLocation> {
  String currentAddress = 'My Address';
  Position? currentposition;

  Future<Position?> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Please enable Your Location Service');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg:
              'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks[0];

      setState(() {
        currentposition = position;
        currentAddress = "${place.locality!.toLowerCase()}";
        print(currentAddress);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Allow Your Location'),
      ),
      backgroundColor: Colors.grey,
      body: Align(
        alignment: Alignment.center,
        child: Container(
          width: 200,
          child: MaterialButton(
            onPressed: () {
              _determinePosition().then((value) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HotelsList(
                              city: currentAddress,
                            )),
                    (route) => false);
              });
            },
            child: Text(
              'Click Here',
              style: TextStyle(
                fontSize: 22.0,
              ),
            ),
            shape: StadiumBorder(),
            color: Colors.blueGrey,
          ),
        ),
      ),
    );
  }
}
