import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_list/models/order.dart';

import '../bloc/order_bloc/order_bloc.dart';

class PreviousPurchasePage extends StatefulWidget {
  const PreviousPurchasePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PreviousPurchasePage();
}

class _PreviousPurchasePage extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: _PreviousPurchasedProductsCart(),
            ),
          ),
        ],
      ),
    );
  }
}

class _PreviousPurchasedProductsCart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return __PreviousPurchasedProductsCart();
  }
}

class __PreviousPurchasedProductsCart extends State {
  FirebaseAuth auth = FirebaseAuth.instance;
  late User user;
  List<Order> purchasedProducts = [];

  @override
  void initState() {
    context.read<OrderBloc>().add(LoadOrdersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
    //   if (purchasedProducts.length == 0) {
    //     return Container(
    //       constraints: BoxConstraints.expand(),
    //       decoration: BoxDecoration(
    //           image: DecorationImage(
    //               image: AssetImage('assets/images/bg1.jpg'), fit: BoxFit.cover)),
    //       child: Center(
    //         child: data == null
    //             ? buildCircularProgressIndicator()
    //             : buildNoPurchaseText(),
    //       ),
    //     );
    //   } else {
    //     return Container(
    //       constraints: BoxConstraints.expand(),
    //       decoration: BoxDecoration(
    //           image: DecorationImage(
    //               image: AssetImage('assets/images/bg1.jpg'), fit: BoxFit.cover)),
    //       child: Container(
    //           padding: EdgeInsets.fromLTRB(
    //               15, 15, 15, MediaQuery.of(context).size.height * 0.09),
    //           child: Column(
    //             children: [
    //               Expanded(
    //                 flex: 9,
    //                 child: ListView.builder(
    //                     itemCount: purchasedProducts.length,
    //                     itemBuilder: (context, index) {
    //                       return Container(
    //                         padding: EdgeInsets.all(5),
    //                         child: ExpansionTileCard(
    //                           baseColor: Colors.white60,
    //                           shadowColor: Colors.white,
    //                           expandedColor: Colors.white70,
    //                           title: Row(
    //                             children: [
    //                               Text(purchasedProducts[index].purchaseDate),
    //                               Expanded(
    //                                   child: Align(
    //                                       alignment: Alignment.centerRight,
    //                                       child: Text(purchasedProducts[index]
    //                                               .cost
    //                                               .toString() +
    //                                           ' TL')))
    //                             ],
    //                           ),
    //                           children: [
    //                             Align(
    //                               alignment: Alignment.centerLeft,
    //                               child: Padding(
    //                                 padding: EdgeInsets.only(left: 15, top: 15),
    //                                 child: Text(purchasedProducts[index]
    //                                     .products
    //                                     .toString()),
    //                               ),
    //                             )
    //                           ],
    //                         ),
    //                       );
    //                     }),
    //               ),
    //               Expanded(
    //                 flex: 1,
    //                 child: Container(
    //                     constraints: BoxConstraints.expand(),
    //                     child: TextButton(
    //                       style: TextButton.styleFrom(
    //                           backgroundColor: Colors.white,
    //                           shape: RoundedRectangleBorder(
    //                               borderRadius: BorderRadius.circular(15))),
    //                       child: Text(
    //                         'SHOW GRAPHS',
    //                         style: TextStyle(
    //                             color: Colors.green, fontWeight: FontWeight.bold),
    //                       ),
    //                       onPressed: () {
    //                         Navigator.pushNamed(context, '/stats_page');
    //                       },
    //                     )),
    //               ),
    //             ],
    //           )),
    //     );
    //   }
    // }

    // CircularProgressIndicator buildCircularProgressIndicator() {
    //   return CircularProgressIndicator(
    //     valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
    //   );
    // }

    // Text buildNoPurchaseText() {
    //   return Text(
    //     "You haven't added any purchases yet.",
    //     style: GoogleFonts.poiretOne(
    //         color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
    //   );
    // }

    // void getPurchasedProducts() async {
    //   User? user = auth.currentUser;
    //   setState(() {
    //     DatabaseService.getPurchasedProducts(user!.uid).then((snapshot) {
    //       var keys = snapshot.value.keys;
    //       var data = snapshot.value;

    //       purchasedProducts.clear();

    //       for (var key in keys) {
    //         PreviousPurchasedProduct _product = new PreviousPurchasedProduct(
    //           double.parse(data[key]['cost'].toString()),
    //           data[key]['purchaseDate'],
    //           data[key]['products'],
    //         );
    //         setState(() {
    //           purchasedProducts.add(_product);
    //         });
    //       }
    //     });
    //   });
  }
}
