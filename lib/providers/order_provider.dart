

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:smartfoodappwithadminpanel/Models/Order_Model.dart';

class OrdersProvider extends ChangeNotifier{

  List<OrderModel> _myOrders=[];
  void getMyOrders() async {
    OrderModel _orderModel;
    List<OrderModel> _newList = [];
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection("Orders")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("myOrders")
        .get();
    value.docs.forEach((data) {
      // print(data.get("ShippingCharges"));
      // print(data.get("TotalAmount"));
      _orderModel = OrderModel(
        itemList: data.get("ItemsList"),
        ShippingCharges: data.get("ShippingCharges"),
        TotalAmount: data.get("TotalAmount")
      );
      _newList.add(_orderModel);
      notifyListeners();
    });
    _myOrders=_newList;
    notifyListeners();
  }

  List<OrderModel> get getMyOrdersList{
    return _myOrders;
  }


}