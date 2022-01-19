import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:smartfoodappwithadminpanel/Models/review_cart_model.dart';
import 'package:smartfoodappwithadminpanel/appColors/colors.dart';
import 'package:smartfoodappwithadminpanel/providers/reviewcart_provider.dart';
import 'package:smartfoodappwithadminpanel/screens/checkout/delieveryDetails/delievery_details.dart';
import 'package:smartfoodappwithadminpanel/widgets/single_item.dart';

// ignore: must_be_immutable
class ReviewCart extends StatelessWidget {
  late ReviewCartProvider reviewCartProvider;

  showAlertDialog(BuildContext context, ReviewCartModel delete) {
    // set up the buttons
    Widget cancelButton = MaterialButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = MaterialButton(
      child: Text("Yes"),
      onPressed: () {
        reviewCartProvider.reviewCartDataDelete(delete.cartId);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Cart Product"),
      content: Text("Are you sure?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showToast() {
    Fluttertoast.showToast(msg: "No Data Found");
  }

  @override
  Widget build(BuildContext context) {
    reviewCartProvider = Provider.of<ReviewCartProvider>(context);
    reviewCartProvider.getReviewCartData();
    return Scaffold(
        bottomNavigationBar: ListTile(
          title: Text("Total Amount"),
          subtitle: Text(
            "Rs ${reviewCartProvider.getTotalPrice()}",
            style: TextStyle(color: Colors.green[700]),
          ),
          trailing: Container(
            width: 160,
            child: MaterialButton(
              onPressed: () async {
                if (reviewCartProvider.getReviewCartDataList.isEmpty) {
                  return showToast();
                }
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DeliveryDetails()));
              },
              color: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text("CheckOut"),
            ),
          ),
        ),
        appBar: AppBar(
          title: Text(
            "Reveiw Cart",
            style: TextStyle(
                color: textColor, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        body: reviewCartProvider.getReviewCartDataList.isEmpty
            ? Center(
                child: Text("No Data"),
              )
            : ListView.builder(
                itemCount: reviewCartProvider.getReviewCartDataList.length,
                itemBuilder: (context, index) {
                  ReviewCartModel data =
                      reviewCartProvider.getReviewCartDataList[index];
                  return Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),

                      SingleItem(
                        adminId: data.adminId,
                        isBool: true,
                        productImage: data.cartImage,
                        productName: data.cartName,
                        productPrice: data.cartPrice,
                        productId: data.cartId,
                        productQuantity: data.cartQuantity,
                        productUnit: data.cartUnit??'small',
                        onDelete: () {
                          showAlertDialog(context, data);
                        },
                      ),
                    ],
                  );
                }));
  }
}
