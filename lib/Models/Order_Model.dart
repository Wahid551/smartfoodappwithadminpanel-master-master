class OrderModel {
  List<dynamic> itemList = [];
  // ignore: non_constant_identifier_names
  num ShippingCharges;
  // ignore: non_constant_identifier_names
  num TotalAmount;

  // ignore: non_constant_identifier_names
  OrderModel(
      {required this.itemList,
      // ignore: non_constant_identifier_names
      required this.ShippingCharges,
      // ignore: non_constant_identifier_names
      required this.TotalAmount});
}
