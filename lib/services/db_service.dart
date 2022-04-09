class DatabaseService {
  // Future<DataSnapshot> getPredictedProducts(String user) async {
  //   var snapshot = reference
  //       .child('smartlist_predictions')
  //       .child('$user')
  //       .orderByKey()
  //       .once();
  //   return snapshot;
  // }

//   Future<DataSnapshot> getProducts() async {
//     var snapshot = reference.child('products').orderByKey().once();
//     return snapshot;
//   }

//   Future<DataSnapshot> getProductsByCategoryId(int categoryId) async {
//     var snapshot = reference
//         .child('products')
//         .orderByChild('categoryId')
//         .equalTo(categoryId)
//         .once();
//     return snapshot;
//   }

//   Future<DataSnapshot> getCategories() async {
//     var snapshot =
//         reference.child('categories').orderByChild('categoryId').once();
//     return snapshot;
//   }

//   Future<DataSnapshot> getPurchasedProducts(String userID) async {
//     var snapshot =
//         reference.child('purchased_products').child('$userID').once();
//     return snapshot;
//   }

//   savePurchasedProducts(Map map, String userID) async {
//     var purchasedRef = reference.child('purchased_products').child('$userID');
//     await purchasedRef.push().set(map);
//   }

//   addNewUser(String email) {
//     userRef.doc(email).set({'userID': email});
//   }

//   addNewPurchase(String email, DateTime date, double cost, String products) {
//     orderRef
//         .doc(email)
//         .collection('pastPurchases')
//         .add({'date': date, 'cost': cost, 'products': products});
//   }

//   Future<QuerySnapshot> getPastPurchases(String email) async {
//     return orderRef.doc(email).collection('pastPurchases').get();
//   }
}
