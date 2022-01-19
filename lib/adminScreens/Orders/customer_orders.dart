import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfoodappwithadminpanel/Models/cutomer_order_model.dart';
import 'package:smartfoodappwithadminpanel/adminScreens/Orders/customer_order_details.dart';
import 'package:smartfoodappwithadminpanel/providers/customer_orders.dart';

class CustomerOrders extends StatefulWidget {
  const CustomerOrders({Key? key}) : super(key: key);

  @override
  _CustomerOrdersState createState() => _CustomerOrdersState();
}

class _CustomerOrdersState extends State<CustomerOrders> {
  late CustomerOrdersProvider _customer;
  @override
  void initState() {
    CustomerOrdersProvider _order = Provider.of(context, listen: false);
    _order.getCustomerOrders();
    super.initState();
  }

  num a = 0;
  @override
  Widget build(BuildContext context) {
    _customer = Provider.of(context);
    // _customer.getCustomerOrders(FirebaseAuth.instance.currentUser!.uid);
    var data = _customer.getCustomerOrdersList;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("Customer Orders"),
      ),
      body: _customer.getCustomerOrdersList.isEmpty
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
                            // print(data.length);
                            CustomerOrderModel order = data[index];
                            return Card(
                              shape: StadiumBorder(),
                              color: Colors.yellow.shade200,
                              child: Container(
                                width: double.infinity,
                                // height: 410,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 7.0, vertical: 10.0),
                                decoration: BoxDecoration(
                                  color: Colors.amberAccent.shade100,
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        // Container(
                                        //   alignment: Alignment.topLeft,
                                        //   padding: EdgeInsets.only(left: 10.0, top: 14.0),
                                        //   child: CircleAvatar(
                                        //     radius: 45,
                                        //     backgroundColor: Colors.amber,
                                        //     // backgroundImage: NetworkImage(order.ItemsList[0]["customerImage"]),
                                        //     child: Text('W'),
                                        //   ),
                                        // ),
                                        SizedBox(width: 7.0),
                                        Container(
                                          padding: EdgeInsets.only(top: 15.0),
                                          child: Text(
                                            order.ItemsList[0]["customerName"],
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                        ),
                                        SizedBox(width: 12.0),
                                        // Container(
                                        //   padding: EdgeInsets.only(top: 30.0),
                                        //   child: Column(
                                        //     children: [
                                        //       Text(
                                        //         "Order id: 348",
                                        //         style:
                                        //         TextStyle(color: Colors.black87, fontSize: 14),
                                        //       ),
                                        //       Text(
                                        //         "Total Amount: 1K",
                                        //         style: TextStyle(
                                        //             color: Colors.black87,
                                        //             fontSize: 14,
                                        //             fontWeight: FontWeight.w700),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                    Divider(
                                      thickness: 1.0,
                                      color: Colors.black,
                                    ),
                                    ListView.builder(
                                      physics: ClampingScrollPhysics(),
                                      // scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: order.ItemsList.length,
                                      itemBuilder: (context, index) {
                                        // print( order.ItemsList.length);
                                        // ItemsListModel  _model=order.itemList[index];
                                        return order.ItemsList[index]
                                                    ["hotelId"] ==
                                                FirebaseAuth
                                                    .instance.currentUser!.uid
                                            ? Row(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10.0, top: 10),
                                                    child: Text(
                                                        order.ItemsList[index]
                                                            ["cartName"],
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          left: 65.0, top: 10),
                                                      child: Image.network(
                                                          order.ItemsList[index]
                                                              ["cartImage"]),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          left: 45.0, top: 10),
                                                      child: Text(
                                                          "${order.ItemsList[index]["cartPrice"]} Rs",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black87,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                    ),
                                                  )
                                                ],
                                              )
                                            : Center();
                                      },
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                            left: 10.0,
                                            top: 15.0,
                                          ),
                                          child: MaterialButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailPageofCustomerOrder(
                                                            customerName: order
                                                                    .ItemsList[0]
                                                                [
                                                                "customerName"],
                                                            customerPhone: order
                                                                    .ItemsList[0]
                                                                [
                                                                "customerPhone"],
                                                            customerAddress: order
                                                                    .ItemsList[0]
                                                                [
                                                                "customerAddress"],
                                                            qauantity: order
                                                                    .ItemsList[
                                                                0]["quantity"],
                                                            order: order,
                                                          )));
                                            },
                                            color: Colors.black87,
                                            child: Text("View Details",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 14.0),
                                    Divider(),
                                  ],
                                ),
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
