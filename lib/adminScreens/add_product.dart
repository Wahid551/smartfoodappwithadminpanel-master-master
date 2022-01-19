import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';
import 'package:smartfoodappwithadminpanel/adminScreens/colors/appcolors.dart';
import 'package:smartfoodappwithadminpanel/providers/product_provider.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final productNameController = TextEditingController();
  final productPriceController = TextEditingController();
  final productDescController = TextEditingController();

  File? selectedImage;
  final picker = ImagePicker();
  // ignore: unused_field
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

  // Upload image to Cloud Storage then Add Data To Firestore
  uploadProduct() async {
    if (formKey.currentState!.validate() && selectedImage != null) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: new Row(
                children: [
                  new CircularProgressIndicator(),
                  SizedBox(
                    width: 25.0,
                  ),
                  new Text("Loading, Please wait"),
                ],
              ),
            ),
          );
        },
      );

      /// uploading image to firebase storage
      Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child("ProductImages")
          .child("${randomAlphaNumeric(9)}.jpg");

      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);

      task.whenComplete(() async {
        try {
          var downloadURL = await firebaseStorageRef.getDownloadURL();
          print("this is url $downloadURL");
          List<String> users = ['Small', 'Medium', 'Large'];
          Map<String, dynamic> productMap = {
            "ProductImage": downloadURL,
            "ProductPrice": int.parse(productPriceController.text),
            "ProductName": productNameController.text,
            "ProductDesc": productDescController.text,
            "ProductCategory": valueChoose,
            "productUnit": users,
            "userUid":
                "${randomAlphaNumeric(9)}${FirebaseAuth.instance.currentUser!.uid}",
            "userDocId": FirebaseAuth.instance.currentUser!.uid,
            'DateTime': DateTime.now().toIso8601String(),
          };

          /// Add Data to Firestore
          _productProvider.addProduct(productMap).then((result) {
            Navigator.of(context).pop();
            // Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text(
                  "Product Added Successfully",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            );
          });
        } catch (onError) {
          print("Error");
        }
      });
      // var downloadUrl =
      //     await (await task.whenComplete(() => null)).ref.getDownloadURL();

    } else {}
  }

  // var _value = 0;
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
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 30),
              child: Text(
                "Add Product",
                textScaleFactor: 1.3,
                style: GoogleFonts.knewave(
                  textStyle: TextStyle(
                      color: AppColors.eigengrauColor,
                      fontSize: 23,
                      fontWeight: FontWeight.bold),
                  letterSpacing: 1.2,
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
                            controller: productNameController,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                fillColor: AppColors.welcomeTextFieldColor,
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
                            controller: productPriceController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Price';
                              }
                              return null;
                            },
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
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: DropdownButton(
                          focusColor: AppColors.coralColor,
                          iconEnabledColor: Colors.redAccent,
                          iconDisabledColor: Colors.black,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
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
                            child: selectedImage != null
                                ? Container(
                                    margin: EdgeInsets.only(right: 18),
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: AppColors.welcomeTextFieldColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: Image.file(
                                        selectedImage!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : Container(
                                    margin: EdgeInsets.only(right: 18),
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: AppColors.welcomeTextFieldColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Icon(Icons.add_photo_alternate,
                                        size: 35, color: Colors.white70),
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
                        controller: productDescController,
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
                        uploadProduct();
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 75),
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black87,
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.firstScreenContainerColor,
                                  spreadRadius: 1,
                                  offset: Offset(1, 0),
                                  blurRadius: 8)
                            ]),
                        child: Center(
                          child: Text("Submit",
                              style: GoogleFonts.knewave(
                                  textStyle: TextStyle(
                                      color: Colors.white, fontSize: 20))),
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
