import 'package:flutter/material.dart';
import 'package:smartfoodappwithadminpanel/appColors/colors.dart';
import 'package:smartfoodappwithadminpanel/screens/reviewCart/review_cart.dart';
import 'package:smartfoodappwithadminpanel/widgets/counter.dart';

enum SigninCharacter { fill, outline }

class ProductOverview extends StatefulWidget {
  late final String productName;
  late final String productImage;
  late final int productPrice;
  late final String productId;
  late final int productQuantity;
  late final String productDesc;
  late final String adminId;
  ProductOverview(
      {required this.productId,
      this.productQuantity = 1,
      required this.productImage,
      required this.productName,
      required this.productPrice,
      required this.productDesc,
      required this.adminId});

  @override
  _ProductOverviewState createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  SigninCharacter character = SigninCharacter.fill;

  // Widget mybottomNavigationBar({
  //   required Color iconColor,
  //   required Color backgroundColor,
  //   required Color textColor,
  //   required String title,
  //   required IconData iconData,
  //   required VoidCallback onTap,
  // }) {
  //   return GestureDetector(
  //     onTap: onTap,
  //     child: Container(
  //       color: backgroundColor,
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Icon(
  //             iconData,
  //             size: 24,
  //             color: iconColor,
  //           ),
  //           SizedBox(
  //             width: 5,
  //           ),
  //           Text(title,
  //               style: TextStyle(
  //                   color: textColor,
  //                   fontWeight: FontWeight.w900,
  //                   fontSize: 17,
  //                   letterSpacing: 1.0))
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: Row(children: [
      //   mybottomNavigationBar(
      //     backgroundColor: primaryColor,
      //     textColor: Colors.black,
      //     iconColor: Colors.black,
      //     title: "Go To Cart",
      //     iconData: Icons.shop_2_outlined,
      //     onTap: () {},
      //   )
      // ]),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: textColor,
        ),
        title: Text(
          "Detail Page",
          style: TextStyle(color: textColor),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  ListTile(
                    title: Text(widget.productName),
                    subtitle: Text('${widget.productPrice}'),
                  ),
                  Container(
                    height: 250,
                    padding: EdgeInsets.all(40),
                    child: Image.network(
                      widget.productImage,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    child: Text("Available Options",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: textColor, fontWeight: FontWeight.w600)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 3,
                              backgroundColor: Colors.green[700],
                            ),
                            Radio(
                              onChanged: (value) {
                                setState(() {
                                  character = value as SigninCharacter;
                                });
                              },
                              activeColor: Colors.green[700],
                              value: SigninCharacter.fill,
                              groupValue: character,
                            ),
                          ],
                        ),
                        Text("\Rs${widget.productPrice}"),
                        Count(
                          adminId: widget.adminId,
                            productName: widget.productName,
                            productId: widget.productId,
                            productImage: widget.productImage,
                            productPrice: widget.productPrice),
                        // Container(
                        //   padding: EdgeInsets.symmetric(
                        //       horizontal: 30, vertical: 10),
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(30),
                        //       border: Border.all(color: Colors.grey)),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Icon(
                        //         Icons.add,
                        //         size: 17,
                        //         color: textColor,
                        //       ),
                        //       Text("ADD",
                        //           style: TextStyle(
                        //             color: textColor,
                        //           ))
                        //     ],
                        //   ),
                        // )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "About This Product",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.productDesc,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReviewCart()));
                    },
                    child: Container(
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13.0),
                        gradient: LinearGradient(colors: [
                          Colors.amber,
                          Color(0xffd1ad17),
                        ]),
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.shop_2_outlined,
                          size: 22,
                          color: textColor,
                        ),
                        title: Text(
                          "Go To Cart",
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.0),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
