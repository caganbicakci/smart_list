import 'package:smart_list/handler/data_type_handler.dart';

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
  int quantity;

  factory PredictedProduct.fromJson(Map<String, dynamic> json) =>
      PredictedProduct(
        price: DataTypeHandler.checkDouble(json["price"].toString()),
        productId: json["productId"],
        productName: json["productName"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "price": price,
        "productId": productId,
        "productName": productName,
        "quantity": quantity,
      };
}
