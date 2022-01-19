

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:smartfoodappwithadminpanel/Models/admin_Model.dart';

class HotelsListProvider with ChangeNotifier{
  List<AdminModel> hotelsList = [];
  void getHotelsList(String city)async{

    List<AdminModel> newList = [];
    QuerySnapshot value= await FirebaseFirestore.instance.collection("adminData").where("HotelCity", isEqualTo:city).get();

    value.docs.forEach((value) {
    AdminModel  adminModel = AdminModel(
        hotelCity: value.get('HotelCity'),
        hotelName: value.get('HotelName'),
        phoneNumber: value.get('PhoneNo'),
        userEmail: value.get('Email'),
        userName: value.get('UserName'),
        userUid: value.get('userId'),
      );
    newList.add(adminModel);
    });
    hotelsList = newList;
    notifyListeners();

  }

  List<AdminModel> get getHotelsDataList {
    return hotelsList;
  }
}