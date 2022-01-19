import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:smartfoodappwithadminpanel/adminScreens/colors/appcolors.dart';
import 'package:smartfoodappwithadminpanel/adminScreens/homeScreen.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regExp = new RegExp(p);

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController hotelNameTextEditingController =
      TextEditingController();
  TextEditingController hotelCityTextEditingController =
      TextEditingController();
  // TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTExtEditingController = TextEditingController();

  bool isLoading = false;
  late UserCredential userCredential;

  // Making a Collection or Sending Data on Firebase Collection through a Function
  Future sendData() async {
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailTextEditingController.text.trim(),
              password: passwordTExtEditingController.text.trim());
      await FirebaseFirestore.instance
          .collection("adminData")
          .doc(userCredential.user?.uid)
          .set({
        'UserName': userNameTextEditingController.text.trim(),
        'PhoneNo': phoneTextEditingController.text.trim(),
        'Email': emailTextEditingController.text.trim(),
        'HotelName': hotelNameTextEditingController.text.trim(),
        'HotelCity': hotelCityTextEditingController.text.trim().toLowerCase(),
        'Password': passwordTExtEditingController.text.trim(),
        'userId': userCredential.user?.uid,
      }).then((value) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => AdminHomePage()),
            (route) => false);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // ignore: deprecated_member_use
        globalKey.currentState?.showSnackBar(SnackBar(
          content: Text("The password provided is too weak."),
        ));
      } else if (e.code == 'email-already-in-use') {
        // ignore: deprecated_member_use
        globalKey.currentState?.showSnackBar(SnackBar(
          content: Text("The account already exists for that email."),
        ));
      }
    } catch (e) {
      // ignore: deprecated_member_use
      globalKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
      setState(() {
        isLoading = false;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  // Validation Function to Check the TextFormField
  void validation() {
    // ignore: unnecessary_null_comparison
    if (userNameTextEditingController.text.trim().isEmpty ||
        // ignore: unnecessary_null_comparison
        userNameTextEditingController.text.trim() == null) {
      // ignore: deprecated_member_use
      globalKey.currentState?.showSnackBar(
        SnackBar(
          content: Text("UserName is Empty"),
        ),
      );
      return;
    }
    // ignore: unnecessary_null_comparison
    if (phoneTextEditingController.text.trim().isEmpty ||
        // ignore: unnecessary_null_comparison
        phoneTextEditingController.text.trim() == null) {
      // ignore: deprecated_member_use
      globalKey.currentState?.showSnackBar(
        SnackBar(
          content: Text("Phone Number is Empty"),
        ),
      );
      return;
    }
    if (hotelNameTextEditingController.text.trim().isEmpty ||
        // ignore: unnecessary_null_comparison
        hotelNameTextEditingController.text.trim() == null) {
      // ignore: deprecated_member_use
      globalKey.currentState?.showSnackBar(
        SnackBar(
          content: Text("Restaurant Name is Empty"),
        ),
      );
      return;
    }
    if (hotelCityTextEditingController.text.trim().isEmpty ||
        // ignore: unnecessary_null_comparison
        hotelCityTextEditingController.text.trim() == null) {
      // ignore: deprecated_member_use
      globalKey.currentState?.showSnackBar(
        SnackBar(
          content: Text("City is Empty"),
        ),
      );
      return;
    }
    if (emailTextEditingController.text.trim().isEmpty ||
        // ignore: unnecessary_null_comparison
        emailTextEditingController.text.trim() == null) {
      // ignore: deprecated_member_use
      globalKey.currentState?.showSnackBar(
        SnackBar(
          content: Text("Email is Empty"),
        ),
      );
      return;
    } else if (!regExp.hasMatch(emailTextEditingController.text)) {
      // ignore: deprecated_member_use
      globalKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(
            "Please Enter Valid Email",
          ),
        ),
      );
      return;
    }
    if (passwordTExtEditingController.text.trim().isEmpty ||
        // ignore: unnecessary_null_comparison
        passwordTExtEditingController.text.trim() == null) {
      // ignore: deprecated_member_use
      globalKey.currentState?.showSnackBar(
        SnackBar(
          content: Text("Password is Empty"),
        ),
      );
      return;
    } else {
      setState(() {
        isLoading = true;
      });
      sendData();
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: globalKey,
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          SafeArea(
            child: isLoading
                ? Container(
                    child: Center(
                      child: JumpingDotsProgressIndicator(
                        numberOfDots: 3,
                        fontSize: 60.0,
                        color: Colors.amber,
                        milliseconds: 300,
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Stack(
                            children: <Widget>[
                              Container(
                                padding:
                                    EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                                child: Text(
                                  'Signup',
                                  style: TextStyle(
                                    fontSize: 80.0,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.eigengrauColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding:
                                    EdgeInsets.fromLTRB(260.0, 125.0, 0.0, 0.0),
                                child: Text(
                                  '.',
                                  style: TextStyle(
                                    fontSize: 80.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: 35.0, left: 20.0, right: 20.0),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: userNameTextEditingController,

                                decoration: InputDecoration(
                                    labelText: 'USERNAME',
                                    prefixIcon: Icon(
                                      Icons.person,
                                    ),
                                    labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                    // hintText: 'EMAIL',
                                    // hintStyle: ,
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blue))),
                              ),
                              SizedBox(height: 10.0),
                              TextFormField(
                                controller: emailTextEditingController,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.email,
                                    ),
                                    labelText: 'EMAIL',
                                    labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                    // hintText: 'EMAIL',
                                    // hintStyle: ,
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blue))),
                              ),
                              SizedBox(height: 10.0),
                              TextFormField(
                                // obscureText: true,
                                controller: phoneTextEditingController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.phone,
                                    ),
                                    labelText: 'PHONE',
                                    labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blue))),
                              ),
                              SizedBox(height: 10.0),
                              TextFormField(
                                // obscureText: true,
                                controller: hotelNameTextEditingController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.hotel,
                                    ),
                                    labelText: 'Hotel/Restaurant Name',
                                    labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blue))),
                              ),
                              SizedBox(height: 10.0),
                              TextFormField(
                                // obscureText: true,
                                keyboardType: TextInputType.text,
                                controller: hotelCityTextEditingController,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.location_city),
                                    labelText: 'Hotel City',
                                    labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blue))),
                              ),
                              SizedBox(height: 10.0),
                              TextFormField(
                                controller: passwordTExtEditingController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.password),
                                  labelText: 'PASSWORD ',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue)),
                                ),
                                obscureText: true,
                              ),
                              SizedBox(height: 50.0),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    validation();
                                  });
                                },
                                child: Container(
                                  height: 40.0,
                                  child: Material(
                                    borderRadius: BorderRadius.circular(20.0),
                                    shadowColor: Color(0xffcd7f32),
                                    color: Colors.black87,
                                    elevation: 7.0,
                                    child: Center(
                                      child: Text(
                                        'SIGNUP',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.0),
                              Container(
                                height: 40.0,
                                color: Colors.transparent,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.amber[300],
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Center(
                                      child: Text(
                                        'Go Back',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat',
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
