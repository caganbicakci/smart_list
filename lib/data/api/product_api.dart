// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:smart_list/models/product.dart';

// class ProductApi {
//   getProducts() async {
//     var response = await http.get(Uri.parse(
//         'https://smartlist-f961b-default-rtdb.firebaseio.com/products.json?apiKey=AIzaSyD45DM_VUVVZTGADu2lhkxV5t3AdX801e8'));
//     List<Product> products = [];

//     var data = jsonDecode(response.body);

//     for (var element in data) {
//       products.add(Product.fromJson(element));
//     }
//     return products;
//   }
// }
