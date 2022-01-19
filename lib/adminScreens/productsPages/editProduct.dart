import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';
import 'package:smartfoodappwithadminpanel/Models/product_model.dart';
import 'package:smartfoodappwithadminpanel/adminScreens/colors/appcolors.dart';
import 'package:smartfoodappwithadminpanel/adminScreens/homeScreen.dart';
import 'package:smartfoodappwithadminpanel/providers/product_provider.dart';

// ignore: must_be_immutable
class EditProducts extends StatefulWidget {
  ProductModel data;
  EditProducts({required this.data});

  @override
  _EditProductsState createState() => _EditProductsState();
}

class _EditProductsState extends State<EditProducts> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  File? selectedImage;
  final picker = ImagePicker();
  bool _isLoading = false;
  late ProductProvider _productProvider;

  // Get Image from Gallery
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  late String productName = widget.data.productName,
      productImage = widget.data.productImage,
      productDesc = widget.data.productDesc;
  // late int productGender = widget.data.genderCategory;
  late String productPrice = widget.data.productPrice.toString();

  // Upload image to Cloud Storage then Add Data To Firestore
  updateProduct() async {
    if (formKey.currentState!.validate() && selectedImage != null) {
      if (selectedImage != null) {
        setState(() {
          _isLoading = true;
        });

        /// uploading image to firebase storage
        Reference firebaseStorageRef = FirebaseStorage.instance
            .ref()
            .child("GigImages")
            .child("${randomAlphaNumeric(9)}.jpg");

        final UploadTask task = firebaseStorageRef.putFile(selectedImage!);

        task.whenComplete(() async {
          try {
            var downloadURL = await firebaseStorageRef.getDownloadURL();
            print("this is url $downloadURL");
            List<String> users = ['Small', 'Medium', 'Large'];
            Map<String, dynamic> gigMap = {
              "ProductImage": downloadURL,
              "ProductPrice": int.parse(productPrice),
              "ProductName": productName,
              "ProductDesc": productDesc,
              "ProductCategory": valueChoose,
              "productUnit": users,
              "userUid": widget.data.userUid,
              "userDocId": widget.data.userDocId,
              'DateTime': DateTime.now().toIso8601String(),
            };

            /// Add Data to Firestore
            _productProvider
                .updateProduct(gigMap, widget.data.userUid)
                .then((result) {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AdminHomePage()));
            });
          } catch (onError) {
            print("Error");
          }
        });
        // var downloadUrl =
        //     await (await task.whenComplete(() => null)).ref.getDownloadURL();

      } else {}
    } else {
      if (formKey.currentState!.validate()) {
        setState(() {
          _isLoading = true;
        });
        List<String> users = ['Small', 'Medium', 'Large'];
        Map<String, dynamic> gigMap = {
          "ProductImage": productImage,
          "ProductPrice": int.parse(productPrice),
          "ProductName": productName,
          "ProductDesc": productDesc,
          "ProductCategory": valueChoose,
          "productUnit": users,
          "userUid": widget.data.userUid,
          "userDocId": widget.data.userDocId,
          'DateTime': DateTime.now().toIso8601String(),
        };
        _productProvider
            .updateProduct(gigMap, widget.data.userUid)
            .then((value) {
          print('Data is uploaded');
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AdminHomePage()));
        });
      }
    }
  }

  @override
  void initState() {
    valueChoose = category();
    super.initState();
  }

  category() {
    return valueChoose = widget.data.productCategory;
  }

  var valueChoose;
  List listItems = [
    "Zinger Burgers",
    "Pizzas",
    "Sweet Dishes",
    "Others",
  ];
  @override
  Widget build(BuildContext context) {
    _productProvider = Provider.of(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: _isLoading
            ? Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 30),
                    child: Text(
                      "Tailor",
                      textScaleFactor: 1.3,
                      style: GoogleFonts.knewave(
                        textStyle: TextStyle(
                            color: AppColors.coralColor,
                            fontSize: 23,
                            fontWeight: FontWeight.bold),
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 12.0),
                    child: Text(
                      "Edit Male Suiting's",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: AppColors.eigengrauColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Form(
                      key: formKey,
                      child: Column(
                        children: [
                          ListTile(
                            leading: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                "Name",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            trailing: Container(
                              padding: EdgeInsets.only(right: 10),
                              child: SizedBox(
                                width: 130,
                                height: 45,
                                child: TextFormField(
                                  initialValue: widget.data.productName,
                                  onChanged: (val) {
                                    setState(() {
                                      productName = val;
                                    });
                                  },
                                  // controller: productNameController,
                                  cursorColor: Colors.black,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                      fillColor:
                                          AppColors.welcomeTextFieldColor,
                                      filled: true,
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide.none,
                                      )),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Name of Product';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          ListTile(
                            leading: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                "Price",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            trailing: Container(
                              padding: EdgeInsets.only(right: 10),
                              child: SizedBox(
                                width: 130,
                                height: 45,
                                child: TextFormField(
                                  initialValue:
                                      widget.data.productPrice.toString(),
                                  onChanged: (val) {
                                    setState(() {
                                      productPrice = val;
                                    });
                                  },
                                  // controller: productPriceController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Price';
                                    }
                                    return null;
                                  },
                                  cursorColor: Colors.black,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                      fillColor:
                                          AppColors.welcomeTextFieldColor,
                                      filled: true,
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide.none,
                                      )),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Container(
                              padding: EdgeInsets.only(left: 16, right: 16),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: DropdownButton(
                                focusColor: AppColors.coralColor,
                                iconEnabledColor: Colors.redAccent,
                                iconDisabledColor: Colors.black,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                elevation: 10,
                                value: valueChoose,
                                onChanged: (val) {
                                  setState(() {
                                    valueChoose = val;
                                  });
                                },
                                hint: Text(
                                  "Select Category",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                dropdownColor: AppColors.apricotColor,
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black,
                                ),
                                iconSize: 34,
                                isExpanded: true,
                                items: listItems.map((valueItem) {
                                  return DropdownMenuItem(
                                    value: valueItem,
                                    child: Text(valueItem),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 15),
                                child: Text(
                                  "Add Picture",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    getImage();
                                  },
                                  child: selectedImage == null
                                      ? Container(
                                          margin: EdgeInsets.only(right: 18),
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            color:
                                                AppColors.welcomeTextFieldColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            child: Image.network(
                                                widget.data.productImage),
                                          ),
                                        )
                                      : Container(
                                          margin: EdgeInsets.only(right: 18),
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            color:
                                                AppColors.welcomeTextFieldColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            child: Image.file(
                                              selectedImage!,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ))
                            ],
                          ),
                          SizedBox(height: 25),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(left: 15),
                            child: Text(
                              "Description",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            child: TextFormField(
                              initialValue: widget.data.productDesc,
                              onChanged: (val) {
                                setState(() {
                                  productDesc = val;
                                });
                              },
                              // controller: productDescController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Description';
                                }
                                return null;
                              },
                              maxLines: 5,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  fillColor: AppColors.welcomeTextFieldColor,
                                  filled: true,
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide.none,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          GestureDetector(
                            onTap: () {
                              updateProduct();
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 75),
                              width: double.infinity,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.eigengrauColor,
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            AppColors.firstScreenContainerColor,
                                        spreadRadius: 1,
                                        offset: Offset(1, 0),
                                        blurRadius: 8)
                                  ]),
                              child: Center(
                                child: Text("Submit",
                                    style: GoogleFonts.knewave(
                                        textStyle: TextStyle(
                                            color: AppColors.coralColor,
                                            fontSize: 20))),
                              ),
                            ),
                          ),
                          SizedBox(height: 60),
                        ],
                      )),
                ],
              ),
      ),
    );
  }
}
