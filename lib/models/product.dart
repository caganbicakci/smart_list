import 'dart:convert';

import '../handler/data_type_handler.dart';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    required this.categoryId,
    required this.imageUrl,
    required this.price,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.quantityPerUnit,
  });

  int categoryId;
  String imageUrl;
  num price;
  String productId;
  String productName;
  double quantity;
  String quantityPerUnit;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        categoryId: json["categoryId"],
        imageUrl: json["imageUrl"],
        price: DataTypeHandler.checkDouble(json["price"].toString()),
        productId: json["productId"],
        productName: json["productName"],
        quantity: DataTypeHandler.checkDouble(json["quantity"].toString()),
        quantityPerUnit: json["quantityPerUnit"],
      );

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "imageUrl": imageUrl,
        "price": price,
        "productId": productId,
        "productName": productName,
        "quantity": quantity,
        "quantityPerUnit": quantityPerUnit,
      };
}
