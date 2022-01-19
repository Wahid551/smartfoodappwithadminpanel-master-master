import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:smartfoodappwithadminpanel/appColors/colors.dart';
import 'package:smartfoodappwithadminpanel/providers/reviewcart_provider.dart';
import 'package:smartfoodappwithadminpanel/widgets/counter.dart';

// ignore: must_be_immutable
class SingleItem extends StatefulWidget {
  bool isBool = false;
  String productImage;
  String productName;
  int productPrice;
  String productId;
  final int productQuantity;
  String adminId;
  VoidCallback onDelete;
  var productUnit;

  SingleItem({
    required this.adminId,
    required this.isBool,
    required this.onDelete,
    required this.productImage,
    required this.productName,
    required this.productId,
    this.productQuantity = 1,
    required this.productPrice,
    this.productUnit,
  });

  @override
  _SingleItemState createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {
  late ReviewCartProvider reviewCartProvider;
  late int count;
  getCount() {
    setState(() {
      count = widget.productQuantity;
    });
  }

  // @override
  // void initState() {
  //   getCount();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    reviewCartProvider = Provider.of<ReviewCartProvider>(context);
    reviewCartProvider.getReviewCartData();
    getCount();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 100,
                  child: Center(
                    child: Image.network(widget.productImage),
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: Container(
                  height: 100,
                  child: Column(
                    mainAxisAlignment: widget.isBool == false
                        ? MainAxisAlignment.spaceAround
                        : MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.productName,
                              style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${widget.productPrice}\Rs",
                              style: TextStyle(color: Colors.black45),
                            ),
                          ]),
                      widget.isBool == false
                          ? InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Wrap(
                                      children: [
                                        ListTile(
                                          title: Text('Small'),
                                        ),
                                        ListTile(
                                          title: Text('Medium'),
                                        ),
                                        ListTile(
                                          title: Text('Large'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 15),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                height: 35,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Small",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 14),
                                      ),
                                    ),
                                    Center(
                                      child: Icon(
                                        Icons.arrow_drop_down,
                                        size: 20,
                                        color: textColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Text(widget.productUnit),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                    height: 100,
                    padding: widget.isBool == false
                        ? EdgeInsets.symmetric(horizontal: 15, vertical: 35)
                        : EdgeInsets.only(left: 15, right: 15),
                    child: widget.isBool == false
                        ? Count(
                      adminId: widget.adminId,
                            productId: widget.productId,
                            productImage: widget.productImage,
                            productName: widget.productName,
                            productPrice: widget.productPrice,
                          )
                        : Column(
                            children: [
                              IconButton(
                                onPressed: widget.onDelete,
                                icon: Icon(
                                  Icons.delete,
                                  size: 30,
                                  color: textColor,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: 25,
                                width: 70,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            if (count == 1) {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "You reached on minimun limit");
                                            } else {
                                              setState(() {
                                                count--;
                                              });
                                              reviewCartProvider
                                                  .updateReviewCartData(
                                                cartImage: widget.productImage,
                                                cartName: widget.productName,
                                                cartId: widget.productId,
                                                cartPrice: widget.productPrice,
                                                cartQuantity: count,
                                                cartUnit: widget.productUnit,

                                              );
                                            }
                                          },
                                          child: Icon(
                                            Icons.remove,
                                            color: Colors.deepPurple,
                                            size: 20,
                                          ),
                                        ),
                                        Text(
                                          "$count",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (count < 10) {
                                              setState(() {
                                                count++;
                                              });
                                              reviewCartProvider
                                                  .updateReviewCartData(
                                                cartImage: widget.productImage,
                                                cartName: widget.productName,
                                                cartId: widget.productId,
                                                cartPrice: widget.productPrice,
                                                cartQuantity: count,
                                              );
                                            }
                                          },
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.deepPurple,
                                            size: 20,
                                          ),
                                        ),
                                      ]),
                                ),
                              )
                            ],
                          )),
              ),
            ],
          ),
        ),
        widget.isBool == false
            ? Container()
            : Divider(
                height: 1,
                color: Colors.black45,
              ),
      ],
    );
  }
}
