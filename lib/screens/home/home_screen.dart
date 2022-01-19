import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfoodappwithadminpanel/Models/product_model.dart';
import 'package:smartfoodappwithadminpanel/Notification/notification.dart';
import 'package:smartfoodappwithadminpanel/appColors/colors.dart';
import 'package:smartfoodappwithadminpanel/providers/product_provider.dart';
import 'package:smartfoodappwithadminpanel/providers/user_provider.dart';
import 'package:smartfoodappwithadminpanel/screens/home/drawer_side.dart';
import 'package:smartfoodappwithadminpanel/screens/home/singal_product.dart';
import 'package:smartfoodappwithadminpanel/screens/myOrders.dart';
import 'package:smartfoodappwithadminpanel/screens/productOverview/product_overview.dart';
import 'package:smartfoodappwithadminpanel/screens/reviewCart/review_cart.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  String uid;
  HomeScreen({required this.uid});
  // ignore: unused_element
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ProductModel> pizzas = [];
  List<ProductModel> burgers = [];
  List<ProductModel> sweetDishes = [];
  @override
  void initState() {
    ProductProvider _productProvider = Provider.of(context, listen: false);
    _productProvider.getAllProducts(widget.uid);
    super.initState();
  }

  late ProductProvider productProvider;
  getPizzas() {
    List<ProductModel> products =
        productProvider.getAllProductsList.where((element) {
      return element.productCategory.toLowerCase().contains("pizzas");
    }).toList();
    return products;
  }

  getBurgers() {
    List<ProductModel> products =
        productProvider.getAllProductsList.where((element) {
      return element.productCategory.toLowerCase().contains("zinger burgers");
    }).toList();
    return products;
  }

  getSweetDishes() {
    List<ProductModel> products =
        productProvider.getAllProductsList.where((element) {
      return element.productCategory.toLowerCase().contains("sweet dishes");
    }).toList();
    return products;
  }

  Widget _buildPizzaProduct(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Pizza",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  )),
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => Search(
                  //               search: productProvider.getPizzaProductDataList,
                  //             )));
                },
                child: Text("view all"),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: pizzas.map(
              (pizzaProductData) {
                return SingalProduct(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductOverview(
                                  productId: pizzaProductData.userUid,
                                  productImage: pizzaProductData.productImage,
                                  productName: pizzaProductData.productName,
                                  productPrice: pizzaProductData.productPrice,
                                  productDesc: pizzaProductData.productDesc,
                                  adminId: pizzaProductData.userDocId,
                                )));
                  },
                  productId: pizzaProductData.userUid,
                  productImage: pizzaProductData.productImage,
                  productName: pizzaProductData.productName,
                  productPrice: pizzaProductData.productPrice,
                  productUnit: pizzaProductData,
                  adminId: pizzaProductData.userDocId,
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildBurgerProduct(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Burger",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  )),
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => Search(
                  //               search:
                  //                   productProvider.getBurgerProductDataList,
                  //             )));
                },
                child: Text("view all"),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: burgers.map((burgerProductData) {
              return SingalProduct(
                  productId: burgerProductData.userUid,
                  productImage: burgerProductData.productImage,
                  productName: burgerProductData.productName,
                  productPrice: burgerProductData.productPrice,
                  productUnit: burgerProductData,
                  adminId: burgerProductData.userDocId,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductOverview(
                                  adminId: burgerProductData.userDocId,
                                  productId: burgerProductData.userUid,
                                  productImage: burgerProductData.productImage,
                                  productName: burgerProductData.productName,
                                  productPrice: burgerProductData.productPrice,
                                  productDesc: burgerProductData.productDesc,
                                )));
                  });
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildRiceProduct(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Rice",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  )),
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => Search(
                  //               search: productProvider.getRicePrductDataList,
                  //             )));
                },
                child: Text("view all"),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: sweetDishes.map((riceProductData) {
            return SingalProduct(
                adminId: riceProductData.userDocId,
                productId: riceProductData.userUid,
                productImage: riceProductData.productImage,
                productName: riceProductData.productName,
                productPrice: riceProductData.productPrice,
                productUnit: riceProductData,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductOverview(
                                adminId: riceProductData.userDocId,
                                productId: riceProductData.userUid,
                                productImage: riceProductData.productImage,
                                productName: riceProductData.productName,
                                productPrice: riceProductData.productPrice,
                                productDesc: riceProductData.productDesc,
                              )));
                });
          }).toList()),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    pizzas = getPizzas();
    burgers = getBurgers();
    sweetDishes = getSweetDishes();
    UserProvider userProvider = Provider.of<UserProvider>(context);
    userProvider.getUserData();
    return Scaffold(
      backgroundColor: Color(0xffcbcbcb),
      drawer: DrawerSide(
        userProvider: userProvider,
      ),
      appBar: AppBar(
        backgroundColor: appBarColor,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          "Home",
          style: TextStyle(color: Colors.black, fontSize: 18.0),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white54,
              child: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Notifications()));
                },
                icon: Icon(
                  Icons.add_alert,
                  color: Color(0xffd6b738),
                  size: 35,
                ),
              ),
            ),
          )
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        primary: true,
        scrollDirection: Axis.vertical,
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.red,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://www.businesslist.pk/img/cats/fast-food.jpg"),
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    // color: Colors.red,
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(right: 130),
                            child: Container(
                              height: 40,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Color(0xffd6b738),
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(50),
                                    bottomLeft: Radius.circular(50),
                                  )),
                              child: Center(
                                child: Text(
                                  "SFE",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      shadows: [
                                        BoxShadow(
                                            color: Colors.green,
                                            blurRadius: 10,
                                            offset: Offset(3, 3))
                                      ]),
                                ),
                              ),
                            )),
                        Text(
                          '30% Off',
                          style: TextStyle(
                              fontSize: 40,
                              color: Colors.green[100],
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            'On all vegetables products',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(),
                )
              ],
            ),
          ),
          _buildPizzaProduct(context),
          _buildBurgerProduct(context),
          _buildRiceProduct(context),
          // _buildDrinkProduct(),
          // _buildChickenPieceProduct(),
        ],
      ),
    );
  }
}
