import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:smartfoodappwithadminpanel/appColors/colors.dart';
import 'package:smartfoodappwithadminpanel/screens/checkout/paymentSummary/payment_summary.dart';

// ignore: must_be_immutable
class DeliveryDetails extends StatefulWidget {
  @override
  _DeliveryDetailsState createState() => _DeliveryDetailsState();
}

enum AddressTypes {
  KarachiToLahore,
  LahoreToKarachi,
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  // late DeliveryAddressModel value;
  String address = "No Data";
  String currentAddress = 'My Address';
  Position? currentposition;
  var myType = AddressTypes.LahoreToKarachi;
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController trainBoxTextEditingController = TextEditingController();

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
        address = currentAddress;
      });
    } catch (e) {
      print(e);
    }
  }

  process() {
    if (globalKey.currentState!.validate()) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PaymentSummary(
            address: address,
            name: userNameTextEditingController.text,
            phone: phoneTextEditingController.text,
            route: myType,
            boxId: trainBoxTextEditingController.text,
            // deliverAddressList: value,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // CheckoutProvider deliveryAddressProvider = Provider.of(context);
    // deliveryAddressProvider.getDeliveryAddressData();
    return Scaffold(
      appBar: AppBar(
        title: Text("Allows Location"),
      ),
      bottomNavigationBar: Container(
        // width: 160,
        height: 48,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: MaterialButton(
          child: address == "No Data"
              ? Text("Get your location")
              : Text("Payment Summary"),
          onPressed: () {
            address == "No Data" ? _determinePosition() : process();
          },
          color: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              30,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Deliver To"),
          ),
          Divider(
            height: 1,
          ),
          SizedBox(
            height: 20.0,
          ),
          // deliveryAddressProvider.getDeliveryAddressList.isEmpty
          //     ?
          Center(
            child: Container(
              child: Center(
                child: Text(
                  address.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20.0,
            ),
            child: Text(
              'Select Route',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 22.0,
              ),
            ),
          ),
          RadioListTile(
            value: AddressTypes.LahoreToKarachi,
            groupValue: myType,
            title: Text("Lahore To Karachi"),
            onChanged: (AddressTypes? value) {
              setState(() {
                myType = value!;
              });
            },
            secondary: Icon(
              Icons.train_outlined,
              color: primaryColor,
            ),
          ),
          RadioListTile(
            value: AddressTypes.KarachiToLahore,
            groupValue: myType,
            title: Text("Karachi To Lahore"),
            onChanged: (AddressTypes? value) {
              setState(() {
                myType = value!;
              });
            },
            secondary: Icon(
              Icons.train_outlined,
              color: primaryColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20.0,
            ),
            child: Text(
              'Enter Credentials',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 22.0,
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Form(
            key: globalKey,
            child: Column(
              children: [
                TextFormField(
                  controller: userNameTextEditingController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: "Enter Name",
                    hintStyle: TextStyle(color: Colors.black54),
                    prefixIcon: Icon(Icons.drive_file_rename_outline),
                    border: UnderlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter First Name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: phoneTextEditingController,
                  style: TextStyle(color: Colors.black),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Enter Phone #",
                    hintStyle: TextStyle(color: Colors.black54),
                    prefixIcon: Icon(Icons.drive_file_rename_outline),
                    border: UnderlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 11) {
                      return 'Please Enter correct Phone Number';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: trainBoxTextEditingController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: "Enter Train Box Number",
                    hintStyle: TextStyle(color: Colors.black54),
                    prefixIcon: Icon(Icons.drive_file_rename_outline),
                    border: UnderlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Train Box Id';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
