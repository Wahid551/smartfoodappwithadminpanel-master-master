import 'package:flutter/material.dart';
import 'package:smartfoodappwithadminpanel/Models/product_model.dart';
import 'package:smartfoodappwithadminpanel/appColors/colors.dart';
import 'package:smartfoodappwithadminpanel/widgets/single_item.dart';

enum SignInCharacter { lowToHigh, highToLow, alphabetically }

// ignore: must_be_immutable
class Search extends StatefulWidget {
  List<ProductModel> search;
  Search({required this.search});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String query = "";
  searchItem(String query) {
    List<ProductModel> searchFood = widget.search.where((element) {
      return element.productName.toLowerCase().contains(query);
    }).toList();
    return searchFood;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    List<ProductModel> _searchItem = searchItem(query);
    return Scaffold(
        appBar: AppBar(title: Text("Search"), actions: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.menu_open_sharp,
            ),
          ),
        ]),
        body: ListView(
          children: [
            ListTile(
              title: Text("Items"),
            ),
            Container(
              height: 52,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    query = value;
                  });
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: textFormFieldColor,
                    filled: true,
                    hintText: "Search Food",
                    suffixIcon: Icon(
                      Icons.search,
                    )),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: _searchItem.map((data) {
                return SingleItem(
                  adminId: "",
                  isBool: false,
                  productImage: data.productImage,
                  productName: data.productName,
                  productPrice: data.productPrice,
                  productId: data.productId,
                  onDelete: () {},
                );
              }).toList(),
            )
          ],
        ));
  }
}
