import 'package:firebase_database/firebase_database.dart';
import '../../models/predicted_product.dart';
import 'dart:convert';

class CartRepository {
  DatabaseReference predictionsRef =
      FirebaseDatabase.instance.ref('smartlist_predictions');

  Future<List<PredictedProduct>?> getPredictedProducts(String userId) async {
    List<PredictedProduct> predictedProducts = [];
    predictionsRef.child(userId).onValue.listen((event) {
      List<dynamic> data = jsonDecode(jsonEncode(event.snapshot.value));
      for (var item in data) {
        predictedProducts.add(PredictedProduct.fromJson(item));
      }
    });
    return predictedProducts;
  }
}
