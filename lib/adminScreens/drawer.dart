import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartfoodappwithadminpanel/adminScreens/Orders/customer_orders.dart';
import 'package:smartfoodappwithadminpanel/adminScreens/add_product.dart';
import 'package:smartfoodappwithadminpanel/adminScreens/colors/appcolors.dart';
import 'package:smartfoodappwithadminpanel/providers/admin_provider.dart';
import 'package:smartfoodappwithadminpanel/welcome_screen.dart';

// ignore: must_be_immutable
class MyDrawer extends StatefulWidget {
  late adminProviderData adminData;
  MyDrawer({required this.adminData});

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.amber.shade200,
            Colors.amberAccent.shade200,
          ]),
        ),
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.amber.shade200,
                Colors.amberAccent.shade200,
              ])),
              accountName: Text(
                widget.adminData.currentUserData.userName,
                style: GoogleFonts.titanOne(
                  textStyle: TextStyle(
                      color: AppColors.eigengrauColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              accountEmail: Text(
                widget.adminData.currentUserData.userEmail,
                style: TextStyle(color: Colors.black87),
              ),
              currentAccountPicture: Container(
                alignment: Alignment.center,
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  widget.adminData.currentUserData.userName.substring(0, 1),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'OverpassRegular',
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ListTile(
              selectedTileColor: AppColors.apricotColor,
              title: Text(
                "Home",
                style: TextStyle(color: Colors.black87, fontSize: 15),
              ),
              leading: Icon(
                CupertinoIcons.home,
                color: Colors.black87,
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigator.push(
                //     context, MaterialPageRoute(
                //     builder: (context) => TailorProfilePage()
                // ));
              },
              child: ListTile(
                selectedTileColor: AppColors.coralColor,
                title: Text(
                  "Profile",
                  style: TextStyle(color: Colors.black87, fontSize: 15),
                ),
                leading: Icon(
                  CupertinoIcons.profile_circled,
                  color: Colors.black87,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddProduct()));
              },
              child: ListTile(
                selectedTileColor: AppColors.apricotColor,
                selected: true,
                title: Text(
                  "Add Product",
                  style: TextStyle(color: Colors.black87, fontSize: 15),
                ),
                leading: Icon(
                  CupertinoIcons.add_circled,
                  color: Colors.black87,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CustomerOrders()));
              },
              child: ListTile(
                selectedTileColor: AppColors.apricotColor,
                selected: true,
                title: Text(
                  "Customer Orders",
                  style: TextStyle(color: Colors.black87, fontSize: 15),
                ),
                leading: Icon(
                  CupertinoIcons.list_bullet_below_rectangle,
                  color: Colors.black87,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Divider(thickness: 2, color: Colors.white),
            ),
            ListTile(
              onTap: () async {
                await FirebaseAuth.instance.signOut().then((value) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>OpenWelcomeScreen()));
                });
              },
              selectedTileColor: AppColors.apricotColor,
              selected: true,
              title: Text(
                "Logout",
                style: TextStyle(color: Colors.black87, fontSize: 15),
              ),
              leading: Icon(
                Icons.logout_outlined,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
