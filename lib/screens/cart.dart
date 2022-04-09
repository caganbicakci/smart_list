import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_list/constants/constants.dart';

import '../bloc/cart_bloc/cart_bloc.dart';

class MyCart extends StatefulWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Smart List",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Constants.themeColor,
          centerTitle: true,
        ),
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg1.jpg'),
                  fit: BoxFit.cover)),
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartInitial) {
                context.read<CartBloc>().add(const CartLoadEvent(
                    userId: "user_e4cfcc06-799d-40b2-9587-faa832e3b28d"));
              }
              if (state is CartLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is CartLoadedState) {
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: ListView.builder(
                        itemCount: state.cartItems.length,
                        itemBuilder: (context, index) => Dismissible(
                          direction: DismissDirection.endToStart,
                          onDismissed: (DismissDirection direction) {
                            // state.cartItems.remove(state.cartItems[index]);
                          },
                          key: UniqueKey(),
                          background: Container(
                            padding: const EdgeInsets.all(10),
                            child: const Align(
                              child: Icon(
                                Icons.delete_forever,
                                color: Colors.white,
                              ),
                              alignment: Alignment.centerRight,
                            ),
                          ),
                          child: Card(
                            color: Colors.white70,
                            shadowColor: Colors.blueGrey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: ListTile(
                                leading: const Icon(Icons.done),
                                title: Text(
                                  state.cartItems[index].productName,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                trailing: Text(
                                  state.cartItems[index].quantity.toString(),
                                )),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Center(child: purchasedArea(context, state)),
                    ),
                  ],
                );
              }
              if (state is CartErrorState) {
                return const Center(
                  child: Text("Something went wrong!"),
                );
              }
              return Container();
            },
          ),
        ));
  }
}

Widget purchasedArea(BuildContext context, CartLoadedState state) {
  double totalCost = 0;
  for (var item in state.cartItems) {
    totalCost += item.price;
  }

  totalCost = double.parse(totalCost.toStringAsFixed(2));

  return Container(
    color: Colors.transparent,
    child: Wrap(
      direction: Axis.horizontal,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          height: 60,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                "${totalCost.toString()} TL",
                style: const TextStyle(fontSize: 15),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        MaterialButton(
            minWidth: MediaQuery.of(context).size.width / 6,
            height: 60,
            onPressed: () async {
              // showDialog(
              //     context: context,
              //     builder: (BuildContext context) {
              //       return savePurchaseAlert(context, totalCost);
              //     });
            },
            color: Colors.green,
            textColor: Colors.white10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(
              Icons.monetization_on_sharp,
              color: Colors.white,
            )),
        const SizedBox(
          width: 10,
        ),
        MaterialButton(
            minWidth: MediaQuery.of(context).size.width / 6,
            height: 60,
            onPressed: () {
              // showProductRemoveAlert(context, cart);
            },
            color: Colors.redAccent,
            textColor: Colors.white10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(
              Icons.delete_forever,
              color: Colors.white,
            )),
      ],
    ),
  );
}

// void showProductRemoveAlert(BuildContext context, CartProvider cart) {
//   showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Attention!"),
//           content: Text('Do you want to remove all products?'),
//           actions: [
//             TextButton(
//               child: Text("No"),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//             TextButton(
//               child: Text("Yes"),
//               onPressed: () {
//                 cart.removeAllProducts();
//                 Navigator.pop(context);
//                 // ScaffoldMessenger.of(context).showSnackBar(
//                 //   showSnackBarMessage("Products are removed"),
//                 // );
//               },
//             ),
//           ],
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//         );
//       });
// }

// Widget showSnackBarMessage(String message) {
//   final _color = const Color.fromRGBO(15, 30, 179, 100);
//   return SnackBar(
//     duration: Duration(milliseconds: 1500),
//     content: Align(
//         alignment: Alignment.center, heightFactor: 1, child: Text(message)),
//     backgroundColor: _color,
//     shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(15), topRight: Radius.circular(15))),
//   );
// }

// Widget savePurchaseAlert(BuildContext context, double totalCost) {
//   FirebaseAuth auth = FirebaseAuth.instance;
//   User user;
//   var cart = context.watch<CartProvider>();
//   var _date = DateTime.now();
//   return AlertDialog(
//     contentPadding: EdgeInsets.zero,
//     content: Container(
//       height: 250,
//       width: MediaQuery.of(context).size.width - 10,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Expanded(
//             flex: 4,
//             child: Container(
//               padding: EdgeInsets.all(20),
//               child: Wrap(
//                 children: [
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(
//                       'Total Cost: ${totalCost.toString()} TL',
//                       style: GoogleFonts.openSans(
//                           fontSize: 18, color: Colors.blueGrey),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 50,
//                   ),
//                   Container(
//                     padding: EdgeInsets.symmetric(vertical: 20),
//                     height: 100,
//                     child: CupertinoDatePicker(
//                       mode: CupertinoDatePickerMode.date,
//                       initialDateTime: DateTime.now(),
//                       onDateTimeChanged: (DateTime newDateTime) {
//                         _date = newDateTime;
//                       },
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: FlatButton(
//               padding: EdgeInsets.zero,
//               onPressed: () async {
//                 var _products = '';
//                 for (var item in cart.items) {
//                   _products += (item.productName.toString() +
//                           " " +
//                           item.quantityPerUnit) +
//                       '\n';
//                 }

//                 var selectedDate = DateFormat('dd-MM-yyyy').format(_date);

//                 cart.addPurchasedProducts(new PreviousPurchasedProduct(
//                     totalCost, selectedDate.toString(), _products));
//                 Navigator.pop(context);
//               },
//               child: Text(
//                 "Save",
//                 style: TextStyle(color: Colors.white),
//               ),
//               color: Colors.green,
//               minWidth: MediaQuery.of(context).size.width - 10,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(15),
//                       bottomRight: Radius.circular(15))),
//             ),
//           ),
//         ],
//       ),
//     ),
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//   );
// }
