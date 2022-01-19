import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfoodappwithadminpanel/Models/review_cart_model.dart';
import 'package:smartfoodappwithadminpanel/appColors/colors.dart';
import 'package:smartfoodappwithadminpanel/providers/notification_provider.dart';
import 'package:smartfoodappwithadminpanel/providers/reviewcart_provider.dart';

import '../../success.dart';

// ignore: must_be_immutable
class PaymentSummary extends StatefulWidget {
  final String address;
  var route;
  final String name;
  final String phone;
  final String boxId;
  PaymentSummary(
      {required this.address,
      required this.phone,
      required this.name,
      required this.route,
      required this.boxId});
  // final DeliveryAddressModel deliverAddressList;
  // PaymentSummary({required this.deliverAddressList});

  @override
  _PaymentSummaryState createState() => _PaymentSummaryState();
}

enum AddressTypes { ByHand }

class _PaymentSummaryState extends State<PaymentSummary> {
  var myType = AddressTypes.ByHand;
  late ReviewCartProvider reviewCartProvider;
  Map<String, dynamic> mapData = Map();
  late List<ReviewCartModel> _review;
  late Notification_provider notify;
  @override
  void initState() {
    ReviewCartProvider _review = Provider.of(context, listen: false);
    _review.getReviewCartData();
    super.initState();
  }

  void placeOrder() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Confirmation',
      desc: 'Are you sure to place order.............',
      btnCancelOnPress: () {
        Navigator.of(context).pop();
      },
      btnOkOnPress: () async {
        await FirebaseFirestore.instance
            .collection("Orders")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("myOrders")
            .add({
          "ItemsList": _review.map((e) {
            return mapData = {
              "cartId": e.cartId,
              "cartName": e.cartName,
              "cartImage": e.cartImage,
              "cartPrice": e.cartPrice,
              "hotelId": e.adminId,
              "customerUid": FirebaseAuth.instance.currentUser!.uid,
              "customerName": widget.name,
              "customerAddress": widget.address,
              "customerPhone": widget.phone,
              "quantity": e.cartQuantity,
              "unit": e.cartUnit,
            };
          }).toList(),
          "ShippingCharges": 50,
          "TotalAmount": _totalPrice + 50,
          "CustomerId": FirebaseAuth.instance.currentUser!.uid,
        });

        await FirebaseFirestore.instance.collection("CustomerOrders").add({
          "ItemsList": _review.map((e) {
            return mapData = {
              "cartId": e.cartId,
              "cartName": e.cartName,
              "cartImage": e.cartImage,
              "cartPrice": e.cartPrice,
              "hotelId": e.adminId,
              "customerUid": FirebaseAuth.instance.currentUser!.uid,
              "customerName": widget.name,
              "customerAddress": widget.address,
              "customerPhone": widget.phone,
              "quantity": e.cartQuantity,
              "unit": e.cartUnit,
            };
          }).toList(),
          "ShippingCharges": 50,
          "TotalAmount": _totalPrice - 50,
          "CustomerId": FirebaseAuth.instance.currentUser!.uid,
        }).then((value) async {
          for (int i = 0; i < _review.length; i++) {
            var id = "";
            Map<String, dynamic> mapData = {
              "msg": "${widget.name} has Placed an Order",
              "time": DateTime.now(),
            };
            // ignore: unrelated_type_equality_checks
            if (_review[i].adminId.isNotEmpty && _review[i].adminId != id) {
              id = _review[i].adminId;
              notify.addData(_review[i].adminId, mapData);
            }
          }
          reviewCartProvider
              .reviewCartDataDelete(FirebaseAuth.instance.currentUser!.uid);
        });
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Success()));
      },
    )..show();
  }

  late double _totalPrice = 0;
  @override
  Widget build(BuildContext context) {
    notify = Provider.of(context);
    reviewCartProvider = Provider.of(context);
    var data = reviewCartProvider.getReviewCartDataList;
    _review = reviewCartProvider.getReviewCartDataList;
    double discount = 10;
    double discountValue = 0;

    // ignore: unused_local_variable
    double shippingCharge = 50;
    // ignore: unused_local_variable
    double? total;
    // ignore: unused_local_variable
    // ignore: unnecessary_statements
    _totalPrice;
    _totalPrice = reviewCartProvider.getTotalPrice();
    if (_totalPrice > 300) {
      discountValue = (_totalPrice * discount) / 100;
      total = _totalPrice - discountValue;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Payment Summary",
          style: TextStyle(fontSize: 18),
        ),
      ),
      bottomNavigationBar: ListTile(
        title: Text("Total Amount"),
        subtitle: Text(
          // ignore: unnecessary_brace_in_string_interps
          "Rs ${_totalPrice + shippingCharge - 10}",
          style: TextStyle(
            color: Colors.green[900],
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        trailing: Container(
          width: 160,
          child: MaterialButton(
            onPressed: () {
              placeOrder();
            },
            child: Text(
              "Place Order",
              style: TextStyle(
                color: textColor,
              ),
            ),
            color: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Text(
                  widget.address.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // SingleDelieveryItem(
                //   address:
                //       "aera, ${widget.deliverAddressList.aera}, street, ${widget.deliverAddressList.street}, society ${widget.deliverAddressList.scoirty}, pincode ${widget.deliverAddressList.pinCode}",
                //   title:
                //       "${widget.deliverAddressList.firstName} ${widget.deliverAddressList.lastName}",
                //   number: widget.deliverAddressList.mobileNo,
                //   addressType: widget.deliverAddressList.addressType ==
                //           "AddressTypes.Home"
                //       ? "Home"
                //       : widget.deliverAddressList.addressType ==
                //               "AddressTypes.Other"
                //           ? "Other"
                //           : "Work",
                // ),
                Divider(),
                ExpansionTile(
                  children: [
                    ListView.builder(
                        itemCount: data.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          ReviewCartModel model = data[index];
                          return ListTile(
                            leading: Image.network(
                              model.cartImage,
                              width: 60.0,
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  model.cartName,
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.bold),
                                ),
                                Text('\Rs ${model.cartPrice}'),
                              ],
                            ),
                            subtitle: Text(""),
                          );
                        }),
                  ],
                  title: Text('Order Items ${data.length}'),
                ),
                Divider(),
                ListTile(
                  minVerticalPadding: 5,
                  leading: Text(
                    "Sub Total",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    // ignore: unnecessary_brace_in_string_interps
                    "\Rs${_totalPrice}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  minVerticalPadding: 5,
                  leading: Text(
                    "Shipping Charge",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  trailing: Text(
                    "\Rs$discountValue",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  minVerticalPadding: 5,
                  leading: Text(
                    "Compen Discount",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  trailing: Text(
                    "\$10",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Text("Payment Options"),
                ),
                RadioListTile(
                  value: AddressTypes.ByHand,
                  groupValue: myType,
                  title: Text("Only By Hand"),
                  onChanged: (AddressTypes? value) {
                    setState(() {
                      myType = value!;
                    });
                  },
                  secondary: Icon(
                    Icons.payment,
                    color: primaryColor,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
