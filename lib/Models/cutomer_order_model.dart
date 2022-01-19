class CustomerOrderModel {
  // ignore: non_constant_identifier_names
  List<dynamic> ItemsList;
  double totalAmount;
  String customerId;

  CustomerOrderModel(
      {required this.customerId,
      required this.totalAmount,
      // ignore: non_constant_identifier_names
      required this.ItemsList});
}
