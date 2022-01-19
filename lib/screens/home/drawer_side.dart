import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartfoodappwithadminpanel/Notification/notification.dart';
import 'package:smartfoodappwithadminpanel/appColors/colors.dart';
import 'package:smartfoodappwithadminpanel/providers/user_provider.dart';
import 'package:smartfoodappwithadminpanel/screens/home/home_screen.dart';
import 'package:smartfoodappwithadminpanel/screens/home/myProfile/my_profile.dart';
import 'package:smartfoodappwithadminpanel/screens/myOrders.dart';
import 'package:smartfoodappwithadminpanel/screens/reviewCart/review_cart.dart';
import 'package:smartfoodappwithadminpanel/welcome_screen.dart';

// ignore: must_be_immutable
class DrawerSide extends StatefulWidget {
  UserProvider userProvider;
  DrawerSide({required this.userProvider});

  @override
  _DrawerSideState createState() => _DrawerSideState();
}

class _DrawerSideState extends State<DrawerSide> {
  Widget listTile(
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, size: 32),
      title: Text(
        title,
        style: TextStyle(color: Colors.black87),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var userData = widget.userProvider.currentUserData;
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          children: [
            DrawerHeader(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 43,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: appBarColor,
                        backgroundImage: NetworkImage(
                             "https://s3.envato.com/files/328957910/vegi_thumb.png"
                            ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(userData.userName),
                        Text(
                          userData.userEmail,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            listTile(
                icon: Icons.home_outlined,
                title: "Home",
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen(uid: '')));
                }),
            listTile(
                icon: Icons.shop_outlined,
                title: "Reveiw Cart",
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ReviewCart()));
                }),
            // listTile(
            //     icon: Icons.person_outlined,
            //     title: "Profile",
            //     onTap: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => MyProfile(
            //                     userProvider: widget.userProvider,
            //                   )));
            //     }),
            listTile(
                icon: Icons.notifications_outlined,
                title: "Notifications",
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Notifications()));
                }),
            listTile(
                icon:Icons.list,
                title: "Orders List",
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => OrdersList()));
                }),
            listTile(
                icon: Icons.logout,
                title: "Logout",
                onTap: ()async{
                  await FirebaseAuth.instance.signOut().then((value) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>OpenWelcomeScreen()));
                  });
                }),
            Container(
                height: 350,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Contact",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text("Call us:"),
                        SizedBox(width: 10),
                        Text("+923147896819"),
                      ],
                    ),
                    SizedBox(height: 7),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Text("Mail us:"),
                          SizedBox(width: 10),
                          Text("sweatokhan@gmail.com"),
                        ],
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
