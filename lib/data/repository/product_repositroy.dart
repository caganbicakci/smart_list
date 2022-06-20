import 'package:firebase_database/firebase_database.dart';
import '../../models/category.dart';

import '../../models/product.dart';
import 'dart:convert';

class ProductRepository {
  DatabaseReference productRef = FirebaseDatabase.instance.ref("products");
  DatabaseReference categoryRef = FirebaseDatabase.instance.ref("categories");

  Future<List<Product>?> getProducts() async {
    List<Product> products = [];
    await productRef.get().then((snapshot) {
      //print(snapshot.children.runtimeType);
      List<dynamic> data = jsonDecode(jsonEncode(snapshot.value));
      for (var item in data) {
        products.add(Product.fromJson(item));
      }
    });
    return products;
  }

  Future<List<Category>?> getProductCategories() async {
    List<Category> categories = [];
    categoryRef.get().then((snapshot) {
      List<dynamic> data = jsonDecode(jsonEncode(snapshot.value));
      for (var item in data) {
        categories.add(Category.fromJson(item));
      }
    });
    return categories;
  }
}
