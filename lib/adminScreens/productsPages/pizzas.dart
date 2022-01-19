import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfoodappwithadminpanel/Models/product_model.dart';
import 'package:smartfoodappwithadminpanel/adminScreens/colors/appcolors.dart';
import 'package:smartfoodappwithadminpanel/adminScreens/productsPages/productDescription.dart';
import 'package:smartfoodappwithadminpanel/providers/product_provider.dart';

class Pizzas extends StatefulWidget {
  const Pizzas({Key? key}) : super(key: key);

  @override
  _PizzasState createState() => _PizzasState();
}

class _PizzasState extends State<Pizzas> {
  List<ProductModel> productData = [];
  late ProductProvider productProvider;

  @override
  void initState() {
    ProductProvider _productProvider = Provider.of(context, listen: false);
    _productProvider.getAdminProducts();
    super.initState();
  }

  getPizzas() {
    List<ProductModel> products =
        productProvider.getAdminProductsList.where((element) {
      return element.productCategory.toLowerCase().contains("pizzas");
    }).toList();
    return products;
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of(context);
    productData = getPizzas();
    return productData.isEmpty
        ? Center(
            child: Container(
              child: Center(
                child: Text("No Data"),
              ),
            ),
          )
        : Padding(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
            child: GridView.builder(
              itemCount: productData.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                ProductModel data = productData[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Description(
                              data: data,
                            )));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.55,
                    width: MediaQuery.of(context).size.width * 0.25,
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: AppColors.platiniumColor,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(1, 1),
                              blurRadius: 5),
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 10.0,
                        ),
                        Expanded(
                          flex: 2,
                          child: Image(
                            image: NetworkImage(data.productImage),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Text(
                          data.productName,
                          style: TextStyle(
                              color: AppColors.trueBlueColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }
}
