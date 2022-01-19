import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smartfoodappwithadminpanel/Notification/notification.dart';
import 'package:smartfoodappwithadminpanel/adminScreens/drawer.dart';
import 'package:smartfoodappwithadminpanel/adminScreens/productsPages/burgers.dart';
import 'package:smartfoodappwithadminpanel/adminScreens/productsPages/others.dart';
import 'package:smartfoodappwithadminpanel/adminScreens/productsPages/pizzas.dart';
import 'package:smartfoodappwithadminpanel/adminScreens/productsPages/sweet_dishes.dart';
import 'package:smartfoodappwithadminpanel/providers/admin_provider.dart';
import 'package:smartfoodappwithadminpanel/providers/product_provider.dart';

import 'colors/appcolors.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    ProductProvider productProvider = Provider.of(context, listen: false);
    productProvider.getAdminProducts();
    super.initState();
    tabController = new TabController(length: 4, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    adminProviderData _adminData = Provider.of<adminProviderData>(context);
    _adminData.getAdminData();
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "My Items",
            style: GoogleFonts.knewave(
              textStyle: TextStyle(color: AppColors.eigengrauColor),
            ),
            textScaleFactor: 1.2,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 13),
              child: GestureDetector(
                onTap: () {
                  {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Notifications()));
                  }
                },
                child: CircleAvatar(
                    radius: 18,
                    backgroundColor: AppColors.eigengrauColor,
                    child: Icon(
                      Icons.add_alert,
                      color: AppColors.coralColor,
                    )),
              ),
            )
          ],
          bottom: TabBar(
              controller: tabController,
              labelColor: AppColors.eigengrauColor,
              labelStyle: TextStyle(
                  color: AppColors.coralColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
              unselectedLabelColor: AppColors.electricBlueColor,
              isScrollable: true,
              indicatorColor: Colors.redAccent,
              tabs: [
                Tab(
                  text: "Zinger Burgers",
                ),
                Tab(
                  text: "Pizzas",
                ),
                Tab(
                  text: "Sweet Dishes",
                ),
                Tab(
                  text: "Others",
                )
              ]),
        ),
        drawer: MyDrawer(
          adminData: _adminData,
        ),
        body: TabBarView(controller: tabController, children: [
          Burgers(),
          Pizzas(),
          SweetDishes(),
          Others(),
        ]));
  }
}
