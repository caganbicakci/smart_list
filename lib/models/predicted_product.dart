class PredictedProduct {
  PredictedProduct({
    required this.price,
    required this.productId,
    required this.productName,
    required this.quantity,
  });

  double price;
  String productId;
  String productName;
  double quantity;

  factory PredictedProduct.fromJson(Map<String, dynamic> json) =>
      PredictedProduct(
        price: json["Price"] as double,
        productId: json["ProductId"],
        productName: json["ProductName"],
        quantity: json["Quantity"] as double,
      );

  Map<String, dynamic> toJson() => {
        "Price": price,
        "ProductId": productId,
        "ProductName": productName,
        "Quantity": quantity,
      };
}
