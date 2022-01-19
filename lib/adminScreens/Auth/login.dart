import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartfoodappwithadminpanel/adminScreens/Auth/signup_screen.dart';
import 'package:smartfoodappwithadminpanel/adminScreens/colors/appcolors.dart';
import 'package:smartfoodappwithadminpanel/adminScreens/homeScreen.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  // ignore: non_constant_identifier_names
  void Login(String email, String password) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: new Row(
              children: [
                new CircularProgressIndicator(),
                SizedBox(
                  width: 25.0,
                ),
                new Text("Loading, Please wait"),
              ],
            ),
          ),
        );
      },
    );
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      // ignore: unused_local_variable
      User? user = result.user;
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AdminHomePage()));
      // if (user!.emailVerified) {
      //   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>TailorMaleSuiting()));
      // }
      // else{
      //   Navigator.of(context).pop();
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //       backgroundColor: Colors.orangeAccent,
      //       content: Text(
      //         "Please Verify Your account by clicking on link",
      //         style: TextStyle(fontSize: 18.0, color: Colors.black),
      //       ),
      //     ),
      //   );
      // }
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "No User Found for that Email",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Wrong Password Provided by User",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
        );
      }
    }
  }

  Widget buildTopPart() {
    return Form(
      key: formkey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextFormField(
              controller: emailEditingController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Email';
                } else if (!value.contains('@')) {
                  return 'Please Enter Valid Email';
                }
                return null;
              },
              style: TextStyle(color: Colors.black),
              // obscureText: true,
              decoration: InputDecoration(
                hintText: "Enter your email",
                hintStyle: TextStyle(color: Colors.black54),
                prefixIcon: Icon(Icons.email),
                border: UnderlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 9),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextFormField(
                controller: passwordEditingController,
                style: TextStyle(color: Colors.black),
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Enter password",
                  hintStyle: TextStyle(color: Colors.black54),
                  prefixIcon: Icon(Icons.remove_red_eye),
                  border: UnderlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Password';
                  }
                  return null;
                }),
          ),
          SizedBox(height: 13),
          Padding(
            padding: const EdgeInsets.only(right: 18),
            child: Align(
              alignment: Alignment.topRight,
              child: Text("Forgot Password?",
                  style: TextStyle(color: Colors.black, fontSize: 15)),
            ),
          ),
          SizedBox(height: 30),
          GestureDetector(
            onTap: () {
              Login(
                  emailEditingController.text, passwordEditingController.text);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black87,
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.firstScreenContainerColor,
                        spreadRadius: 1,
                        offset: Offset(1, 0),
                        blurRadius: 8)
                  ]),
              child: Center(
                child: Text("Login",
                    style: GoogleFonts.knewave(
                        textStyle:
                            TextStyle(color: Colors.white, fontSize: 20))),
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            "If you don't have account?",
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 15,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegisterPage()));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 33),
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  child: Text(
                    "REGISTER",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.navajoWhiteColor,
              child: SvgPicture.asset(
                "assets/login.svg",
                width: double.infinity,
              ),
            ),
            SizedBox(height: 15),
            Center(
              child: Text(
                "Login",
                style: GoogleFonts.pollerOne(
                    textStyle: TextStyle(
                        color: AppColors.eigengrauColor,
                        fontSize: 18,
                        letterSpacing: 1.2)),
                textScaleFactor: 1.3,
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                "Please! login to continue",
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ),
            SizedBox(height: 70),
            buildTopPart(),
          ],
        ),
      ),
    );
  }
}
