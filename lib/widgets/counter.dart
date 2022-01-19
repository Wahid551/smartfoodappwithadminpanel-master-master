import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfoodappwithadminpanel/appColors/colors.dart';
import 'package:smartfoodappwithadminpanel/providers/reviewcart_provider.dart';

// ignore: must_be_immutable
class Count extends StatefulWidget {
  String productName;
  String productImage;
  String productId;
  int productPrice;
  var productUnit;
  String adminId;

  Count({
    required this.adminId,
    required this.productName,
    required this.productId,
    required this.productImage,
    required this.productPrice,
    this.productUnit,
  });

  @override
  _CountState createState() => _CountState();
}

class _CountState extends State<Count> {
  int count = 1;
  bool isBool = false;
  late ReviewCartProvider reviewCartProvider;
  getAddAndQuantity() {
    FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("MyReviewCart")
        .doc(widget.productId)
        .get()
        .then(
          (value) => {
            if (this.mounted)
              {
                if (value.exists)
                  {
                    setState(() {
                      count = value.get("cartQuantity");
                      isBool = value.get("isAdd");
                    })
                  }
              }
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    reviewCartProvider =
    Provider.of<ReviewCartProvider>(context);
    getAddAndQuantity();
    // // ignore: unused_local_variable

    return Container(
        height: 25,
        width: 70,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: isBool == true
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      if (count == 1) {
                        setState(() {
                          isBool = false;
                        });
                        reviewCartProvider
                            .reviewCartDataDelete(widget.productId);
                      } else if (count > 1) {
                        setState(() {
                          count--;
                        });
                        reviewCartProvider.updateReviewCartData(
                          cartId: widget.productId,
                          cartImage: widget.productImage,
                          cartName: widget.productName,
                          cartPrice: widget.productPrice,
                          cartQuantity: count,
                          cartUnit: widget.productUnit,
                        );
                      }
                    },
                    child: Icon(
                      Icons.remove,
                      size: 18,
                      color: textColor,
                    ),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    "$count",
                    style: TextStyle(
                        color: Colors.deepPurple, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        count++;
                      });
                      reviewCartProvider.updateReviewCartData(
                        cartId: widget.productId,
                        cartImage: widget.productImage,
                        cartName: widget.productName,
                        cartPrice: widget.productPrice,
                        cartQuantity: count,
                        cartUnit: widget.productUnit,
                      );
                    },
                    child: Icon(
                      Icons.add,
                      size: 18,
                      color: textColor,
                    ),
                  ),
                ],
              )
            : Center(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isBool = true;
                    });
                    reviewCartProvider.addReviewCartData(
                      cartId: widget.productId,
                      cartImage: widget.productImage,
                      cartName: widget.productName,
                      cartPrice: widget.productPrice,
                      cartQuantity: count,
                      cartUnit: widget.productUnit??'small',
                      adminId: widget.adminId,
                    );
                  },
                  child: Text(
                    "ADD",
                    style: TextStyle(
                        color: textColor, fontWeight: FontWeight.w700),
                  ),
                ),
              ));
  }
}
