import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_list/models/order.dart';

class OrderRepository {
  FirebaseFirestore firestoreRef = FirebaseFirestore.instance;

  Future<List<Order>?> getOrders() async {
    var user = FirebaseAuth.instance.currentUser;
    List<Order> orders = [];
    if (user != null) {
      var querySnapshot = await firestoreRef
          .collection("orders")
          .doc(user.email)
          .collection("pastPurchases")
          .get();

      for (var record in querySnapshot.docs) {
        orders.add(Order.fromSnapshot(record.data()));
      }
      return orders;
    }
  }
}
