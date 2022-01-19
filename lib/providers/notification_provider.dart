import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:smartfoodappwithadminpanel/Models/notification.dart';

// ignore: camel_case_types
class Notification_provider extends ChangeNotifier {
  FirebaseFirestore _user = FirebaseFirestore.instance;

  bool isLoading = false;
  // ignore: non_constant_identifier_names
  void addData(UserId, mapdata) async {
    isLoading = true;
    notifyListeners();
    await FirebaseFirestore.instance
        .collection("Notifications")
        .doc(UserId)
        .collection("MyNotifications")
        .add(
          mapdata,
        );
    isLoading = false;
    notifyListeners();
  }

  List<NotifyModel> _notifyData = [];
  void getData() async {
    NotifyModel _notifyModel;
    List<NotifyModel> _newList = [];
    QuerySnapshot data = await _user
        .collection("Notifications")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("MyNotifications")
        .orderBy("time")
        .get();

    data.docs.forEach((element) {
      _notifyModel = NotifyModel(notification: element.get("msg"));
      _newList.add(_notifyModel);
    });
    _notifyData = _newList;
    notifyListeners();
  }

  List<NotifyModel> get getnotifyData {
    return _notifyData;
  }
}
