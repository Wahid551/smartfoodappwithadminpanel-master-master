import 'package:flutter/material.dart';
import 'package:smartfoodappwithadminpanel/adminScreens/Auth/login.dart';
import 'package:smartfoodappwithadminpanel/userRegistration/userlogin.dart';

class OpenWelcomeScreen extends StatefulWidget {
  const OpenWelcomeScreen({Key? key}) : super(key: key);

  @override
  _OpenWelcomeScreenState createState() => _OpenWelcomeScreenState();
}

class _OpenWelcomeScreenState extends State<OpenWelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffffb347),
                Color(0xffffc87c)
              ],
            )
        ),
        child: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100.0, left: 90 ),
                child: Text(
                  "Welcome To The",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Colors.deepOrange
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60.0, top: 5.0),
                child: Text(
                  "SMART FOOD APP",
                  textScaleFactor: 1.2,
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w900,
                      color: Colors.black
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Image.asset("assets/shak.png", fit: BoxFit.fill,),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                    "Select User Type",
                    textScaleFactor: 1.3,
                    style:  TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17)),
              ),

              SizedBox(height: 20),
              GestureDetector(
                onTap: (){
                  Navigator.push(context,  MaterialPageRoute(builder: (ctx)=> AdminLogin()));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black
                  ),
                  child: ListTile(
                    title: Text(
                      "As a Admin",
                      style: TextStyle(color: Colors.amber, fontWeight: FontWeight.w700),
                      textScaleFactor: 1.0,
                    ),
                    leading: Icon(Icons.cut_rounded,color: Colors.amber,),
                  ),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: (){
                  Navigator.push(context,  MaterialPageRoute(builder: (ctx)=> UserLogin()));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black
                  ),
                  child: ListTile(
                    title: Text(
                      "As a User",
                      style: TextStyle(color: Colors.amber, fontWeight: FontWeight.w700),
                      textScaleFactor: 1.0,
                    ),
                    leading: Icon(Icons.face,color: Colors.amber,),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
