import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:smart_list/models/product.dart';
import 'dart:convert';

class CartRepository {
  DatabaseReference predictionsRef =
      FirebaseDatabase.instance.ref('smartlist_predictions');

  FirebaseFirestore firestoreRef = FirebaseFirestore.instance;

  Future<List<Product>?> getCartItems() async {
    List<Product> cartItems = [];
    predictionsRef
        .child(await getPredictionIdForCurrentUser())
        .onValue
        .listen((event) {
      List<dynamic> data = jsonDecode(jsonEncode(event.snapshot.value));
      for (var item in data) {
        cartItems.add(Product.fromJson(item));
      }
    });
    return cartItems;
  }

  getPredictionIdForCurrentUser() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var data = await firestoreRef.collection('users').doc(user.email).get();
      return data['userID'].toString();
    }
  }
}
