import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfoodappwithadminpanel/Models/Order_Model.dart';
import 'package:smartfoodappwithadminpanel/providers/order_provider.dart';

class OrdersList extends StatefulWidget {
  const OrdersList({Key? key}) : super(key: key);

  @override
  _OrdersListState createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  late OrdersProvider _ordersProvider;
  @override
  void initState() {
    OrdersProvider ordersProvider = Provider.of(context, listen: false);
    ordersProvider.getMyOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _ordersProvider = Provider.of(context);
    var data = _ordersProvider.getMyOrdersList;
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        title: Text(
          "My Orders",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFFF7643),
        elevation: 0.0,
        // automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.white),
        // leading: child,
        // actions: action,
      ),
      body: data.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage("assets/orders.png"),
                    height: 150.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "No Orders Yet",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Color(0xFF303030),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            OrderModel order = data[index];
                            return Card(
                              elevation: 2.0,
                              color: Colors.grey.shade200,
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Card(
                                    child: Column(
                                      children: [
                                        ExpansionTile(
                                          title: Text(
                                              'Ordered Items ${order.itemList.length}'),
                                          children: [
                                            ListView.builder(
                                              physics: ClampingScrollPhysics(),
                                              // scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemCount: order.itemList.length,
                                              itemBuilder: (context, index) {
                                                print(order.itemList.length);
                                                // ItemsListModel  _model=order.itemList[index];
                                                return ListTile(
                                                  leading: Image.network(
                                                    order.itemList[index]
                                                        ["cartImage"],
                                                    width: 60.0,
                                                  ),
                                                  title: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        order.itemList[index]
                                                            ["cartName"],
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text('\Rs' +
                                                          order.itemList[index]
                                                                  ["cartPrice"]
                                                              .toString()),
                                                    ],
                                                  ),
                                                  subtitle: Text(
                                                    (order.itemList[index]
                                                            ["quantity"])
                                                        .toString(),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                  ListTile(
                                    leading: Text(
                                      "Shipping Charges",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14.0),
                                    ),
                                    trailing: Text("50"),
                                  ),
                                  ListTile(
                                    leading: Text(
                                      "Sub Total",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    trailing:
                                        Text(order.TotalAmount.toString()),
                                  ),
                                  Divider(),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
// ClipRRect(
// borderRadius: BorderRadius.circular(20),
// child: Container(
// height: 80,
// width: 80,
// child: Image.asset(
// Helper.getAssetName("hamburger.jpg", "real"),
// fit: BoxFit.cover,
// ),
// ),
// ),
