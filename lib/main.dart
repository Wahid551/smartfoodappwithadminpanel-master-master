import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfoodappwithadminpanel/appColors/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smartfoodappwithadminpanel/providers/admin_provider.dart';
import 'package:smartfoodappwithadminpanel/providers/check_out_provider.dart';
import 'package:smartfoodappwithadminpanel/providers/customer_orders.dart';
import 'package:smartfoodappwithadminpanel/providers/hotels_listLprovider.dart';
import 'package:smartfoodappwithadminpanel/providers/location_provider.dart';
import 'package:smartfoodappwithadminpanel/providers/notification_provider.dart';
import 'package:smartfoodappwithadminpanel/providers/order_provider.dart';
import 'package:smartfoodappwithadminpanel/providers/product_provider.dart';
import 'package:smartfoodappwithadminpanel/providers/reviewcart_provider.dart';
import 'package:smartfoodappwithadminpanel/providers/user_provider.dart';
import 'package:smartfoodappwithadminpanel/screens/home/home_screen.dart';
import 'package:smartfoodappwithadminpanel/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<ReviewCartProvider>(
          create: (context) => ReviewCartProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<CheckoutProvider>(
          create: (context) => CheckoutProvider(),
        ),
        ChangeNotifierProvider<adminProviderData>(
          create: (context) => adminProviderData(),
        ),
        ChangeNotifierProvider<HotelsListProvider>(
          create: (context) => HotelsListProvider(),
        ),
        ChangeNotifierProvider<Notification_provider>(
          create: (context) => Notification_provider(),
        ),
        ChangeNotifierProvider<OrdersProvider>(
          create: (context) => OrdersProvider(),
        ),
        ChangeNotifierProvider<CustomerOrdersProvider>(
          create: (context) => CustomerOrdersProvider(),
        ),
        ChangeNotifierProvider<LocationProvider>(
          create: (context) => LocationProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.white,
            scaffoldBackgroundColor: scaffoldBackgroundColor),
        home: SplashScreen(),
        // home: AdminLogin(),
      ),
    );
  }
}
