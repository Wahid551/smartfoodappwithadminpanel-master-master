import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:smartfoodappwithadminpanel/Models/cutomer_order_model.dart';


class CustomerOrdersProvider extends ChangeNotifier {
  List<CustomerOrderModel> _customerOrders = [];

  void getCustomerOrders() async {
    CustomerOrderModel _orderModel;
    List<CustomerOrderModel> _newList = [];
    QuerySnapshot data =
        await FirebaseFirestore.instance.collection("CustomerOrders").get();

    data.docs.forEach((element) {
      _orderModel = CustomerOrderModel(

        totalAmount: element.get("TotalAmount"),
        ItemsList: element.get("ItemsList"),
        customerId: element.get("CustomerId"),
      );
      _newList.add(_orderModel);
      notifyListeners();
    });
    _customerOrders=_newList;
    notifyListeners();
  }


  List<CustomerOrderModel> get getCustomerOrdersList{
    return _customerOrders;
  }
}
