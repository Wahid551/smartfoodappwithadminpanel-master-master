class ProductModel {
   String productImage;
   String productName;
  int productPrice;
  String productDesc;
  String productCategory;
   String productId;
  String userUid;
   String userDocId;
  List<dynamic> productUnit;

  ProductModel({
    required this.productDesc,
    required this.productCategory,
    required this.userDocId,
    required this.userUid,
    required this.productImage,
    required this.productName,
    required this.productPrice,
    required this.productId,
    required this.productUnit,
  });
}
