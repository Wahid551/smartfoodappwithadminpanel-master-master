import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:smartfoodappwithadminpanel/Models/admin_Model.dart';

// ignore: camel_case_types
class adminProviderData with ChangeNotifier {
  late AdminModel currentData;

  void getAdminData() async {
    AdminModel adminModel;
    var value = await FirebaseFirestore.instance
        .collection("adminData")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (value.exists) {
      adminModel = AdminModel(
        hotelCity: value.get('HotelCity'),
        hotelName: value.get('HotelName'),
        phoneNumber: value.get('PhoneNo'),
        userEmail: value.get('Email'),
        userName: value.get('UserName'),
        userUid: value.get('userId'),
      );
      currentData = adminModel;
      notifyListeners();
    }
  }

  AdminModel get currentUserData {
    return currentData;
  }
}
