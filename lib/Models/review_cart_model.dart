class ReviewCartModel {
  String cartId;
  String cartImage;
  String cartName;
  int cartPrice;
  int cartQuantity;
  String adminId;
  var cartUnit;
  ReviewCartModel({
    required this.adminId,
    required this.cartId,
    required this.cartImage,
    required this.cartName,
    required this.cartPrice,
    required this.cartQuantity,
    this.cartUnit,
  });
}
