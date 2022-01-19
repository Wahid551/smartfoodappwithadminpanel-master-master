import 'package:flutter/material.dart';
import 'package:smartfoodappwithadminpanel/Models/product_model.dart';
import 'package:smartfoodappwithadminpanel/widgets/counter.dart';
import 'package:smartfoodappwithadminpanel/widgets/product_unit.dart';

class SingalProduct extends StatefulWidget {
  late final String productImage;
  late final String productName;
  late final VoidCallback onTap;
  late final int productPrice;
  late final String productId;
  late final String adminId;
  final ProductModel productUnit;
  SingalProduct(
      {required this.productImage,
      required this.productName,
      required this.productPrice,
      required this.productId,
      required this.productUnit,
        required this.adminId,
      required this.onTap});

  @override
  _SingalProductState createState() => _SingalProductState();
}

class _SingalProductState extends State<SingalProduct> {
  var unitData;
  var firstValue;
  @override
  Widget build(BuildContext context) {
    widget.productUnit.productUnit.firstWhere((element) {
      setState(() {
        firstValue = element;
      });
      return true;
    });

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            height: 250,
            width: 160,
            decoration: BoxDecoration(
              color: Color(0xffd9dad9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: widget.onTap,
                  child: Container(
                    height: 150,
                    padding: EdgeInsets.all(5),
                    width: double.infinity,
                    child: Image.network(widget.productImage),
                  ),
                ),
                Expanded(
                  // flex: 4,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.productName,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            )),
                        Text(
                            "${widget.productPrice}\Rs/${unitData == null ? firstValue : unitData}",
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              // flex:4,
                              child: ProductUnit(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Wrap(
                                          children: widget
                                              .productUnit.productUnit
                                              .map<Widget>((data) {
                                            return Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                                  child: InkWell(
                                                    onTap: () async {
                                                      setState(() {
                                                        unitData = data;
                                                      });
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text(
                                                      data,
                                                      style: TextStyle(

                                                          color:
                                                              Colors.deepPurple,

                                                          fontSize: 18),
                                                      // textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            );
                                          }).toList(),
                                        );
                                      },
                                    );
                                  },
                                  title:
                                      unitData == null ? firstValue : unitData),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Count(
                              productId: widget.productId,
                              productImage: widget.productImage,
                              productName: widget.productName,
                              productPrice: widget.productPrice,
                              productUnit:
                                  unitData == null ? firstValue : unitData,
                              adminId: widget.adminId,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
