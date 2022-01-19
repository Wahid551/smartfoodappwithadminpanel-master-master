import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:smartfoodappwithadminpanel/Models/product_model.dart';

class ProductProvider with ChangeNotifier {
  //////////////// Making Object of ProductModel ////////////////////////
  late ProductModel productModel;

  List<ProductModel> search = [];

/////////////// Making a Function to Save Ourself From Writing same code again and again
  productModels(QueryDocumentSnapshot element) {
    productModel = ProductModel(
      productCategory: '',
      productDesc: '',
      userDocId: '',
      userUid: '',
      productImage: element.get("productImage"),
      productName: element.get("productName"),
      productPrice: element.get("productPrice"),
      productId: element.get("productId"),
      productUnit: element.get("productUnit"),
      // productQuantity: element.get("productQuantity"),
    );
    search.add(productModel);
  }

  /////////////////////// Get Pizza Product Data From Firebase ///////////////////////////
  List<ProductModel> pizzaList = [];

  fetchPizzaProductData() async {
//////// Making New List To Avoid for Overlapping of Same Data //////////////////////
    List<ProductModel> newPizzaList = [];

    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("pizzaProduct").get();
    value.docs.forEach(
      (element) {
        // productModel = ProductModel(
        //   productImage: element.get("productImage"),
        //   productName: element.get("productName"),
        //   productPrice: element.get("productPrice"),
        // );
        productModels(element);
        newPizzaList.add(productModel);
      },
    );
    pizzaList = newPizzaList;
    notifyListeners();
  }

  List<ProductModel> get getPizzaProductDataList {
    return pizzaList;
  }
  //// Fetch Products Data
  List<ProductModel> allProductsList = [];

  // Get Admin Products
  void getAllProducts(String uid) async {
    ProductModel _productModel;
    List<ProductModel> _newList = [];
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection("Products")
        .doc(uid)
        .collection("MyProducts")
        .get();
    value.docs.forEach((data) {
      _productModel = ProductModel(
        productDesc: data.get('ProductDesc'),
        productCategory: data.get('ProductCategory'),
        productId: '',
        productUnit: data.get('productUnit'),
        userUid: data.get("userUid"),
        productImage: data.get("ProductImage"),
        productName: data.get("ProductName"),
        userDocId: data.get("userDocId"),
        productPrice: data.get("ProductPrice"),
      );
      _newList.add(_productModel);
      notifyListeners();
    });
    allProductsList = _newList;
    notifyListeners();
  }

  List<ProductModel> get getAllProductsList {
    return allProductsList;
  }

/////////////////////////// Get the Burger Product Data From Firebase ///////////////////////// ///

  List<ProductModel> burgerList = [];

  fetchBurgerProductData() async {
    List<ProductModel> newBurgerList = [];

    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("burgerProduct").get();
    value.docs.forEach(
      (element) {
        // productModel = ProductModel(
        //   productImage: element.get("productImage"),
        //   productName: element.get("productName"),
        //   productPrice: element.get("productPrice"),
        // );
        productModels(element);
        newBurgerList.add(productModel);
      },
    );
    burgerList = newBurgerList;
    notifyListeners();
  }

  List<ProductModel> get getBurgerProductDataList {
    return burgerList;
  }

//////////////////////// Fetching Rice List Data From Firebase ////////////////////////////
  List<ProductModel> riceList = [];

  fetchRiceProductData() async {
    List<ProductModel> newRiceList = [];
    QuerySnapshot value =
        await FirebaseFirestore.instance.collection('riceProduct').get();
    value.docs.forEach((element) {
      // productModel = ProductModel(
      //   productImage: element.get("productImage"),
      //   productName: element.get("productName"),
      //   productPrice: element.get("productPrice"),
      // );
      productModels(element);
      newRiceList.add(productModel);
    });
    riceList = newRiceList;
    notifyListeners();
  }

  List<ProductModel> get getRicePrductDataList {
    return riceList;
  }

  /////////////////// Search Return ////////////
  List<ProductModel> get getAllProductSearch {
    return search;
  }

  // Add Product
  Future<void> addProduct(productData) async {
    FirebaseFirestore.instance
        .collection("Products")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("MyProducts")
        .add(productData)
        .then((value) {
      FirebaseFirestore.instance
          .collection("AllProducts")
          .doc()
          .set(productData);
    }).catchError((e) {
      print(e);
    });
    notifyListeners();
  }

  List<ProductModel> adminProductList = [];

  // Get Admin Products
  void getAdminProducts() async {
    ProductModel _productModel;
    List<ProductModel> _newList = [];
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection("Products")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("MyProducts")
        .get();
    value.docs.forEach((data) {
      _productModel = ProductModel(
        productDesc: data.get('ProductDesc'),
        productCategory: data.get('ProductCategory'),
        productId: '',
        productUnit: data.get('productUnit'),
        userUid: data.get("userUid"),
        productImage: data.get("ProductImage"),
        productName: data.get("ProductName"),
        userDocId: data.get("userDocId"),
        productPrice: data.get("ProductPrice"),
      );
      _newList.add(_productModel);
      notifyListeners();
    });
    adminProductList = _newList;
    notifyListeners();
  }

  List<ProductModel> get getAdminProductsList {
    return adminProductList;
  }

  // Update Product

  Future<void> updateProduct(productData,uid) async {

    FirebaseFirestore.instance
        .collection("Products")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("MyProducts")
        .where("userUid", isEqualTo: uid)
        .get()
        .then((res) {
      print(res.docs.length);
      FirebaseFirestore.instance
          .collection("Products")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("MyProducts")
          .doc(res.docs[0].id)
          .update(productData);
      notifyListeners();

    });

    FirebaseFirestore.instance
        .collection("AllProducts").where("userUid",isEqualTo: uid).get().then((res){
      FirebaseFirestore.instance.collection("AllProducts").doc(res.docs[0].id).update(productData);
      notifyListeners();
    });



    notifyListeners();

  }
  // Delete Product

  Future<void >deleteProduct(uid)async{
    FirebaseFirestore.instance
        .collection("Products")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("MyProducts")
        .where("userUid", isEqualTo: uid)
        .get()
        .then((res) {
      print(res.docs.length);
      FirebaseFirestore.instance
          .collection("Products")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("MyProducts")
          .doc(res.docs[0].id).delete();
      notifyListeners();

    });

    FirebaseFirestore.instance
        .collection("AllProducts").where("userUid",isEqualTo: uid).get().then((res){
      FirebaseFirestore.instance.collection("AllProducts").doc(res.docs[0].id).delete();
      notifyListeners();
    });
  }
}
