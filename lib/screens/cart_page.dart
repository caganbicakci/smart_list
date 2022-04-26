import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_list/constants/theme_constants.dart';
import 'package:smart_list/models/predicted_product.dart';

import '../bloc/cart_bloc/cart_bloc.dart';

class MyCart extends StatefulWidget {
  MyCart({Key? key}) : super(key: key);

  List<PredictedProduct> products = [];
  var totalCost = 0.0;

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
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: ThemeConstants.themeColor,
          centerTitle: true,
        ),
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg1.jpg'),
                  fit: BoxFit.cover)),
          child: BlocConsumer<CartBloc, CartState>(
            listener: (context, state) {
              if (state is CartLoadedState) {
                for (var product in widget.products) {
                  widget.totalCost = product.price;
                }
              }
            },
            builder: (context, state) {
              // if (state is CartInitial) {
              //   context.read<CartBloc>().add(const CartLoadEvent(
              //       userId: "user_e4cfcc06-799d-40b2-9587-faa832e3b28d"));
              // }
              if (state is CartLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is CartLoadedState) {
                widget.products = state.cartItems;
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height * 0.80,
                      child: ListView.builder(
                        itemCount: state.cartItems.length,
                        itemBuilder: (context, index) => Dismissible(
                          direction: DismissDirection.endToStart,
                          onDismissed: (DismissDirection direction) {
                            BlocProvider.of<CartBloc>(context).add(
                                RemoveFromCart(
                                    product: widget.products[index]));
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
                                leading: CircleAvatar(
                                  backgroundColor: Colors.white54,
                                  child: FittedBox(
                                    child: Text(
                                        widget.products[index].quantity
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(color: Colors.black)),
                                  ),
                                ),
                                title: Text(
                                  widget.products[index].productName,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                trailing: Text(
                                  "${widget.products[index].price} TL",
                                )),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                          child: purchasedArea(context, widget.totalCost)),
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

Widget purchasedArea(BuildContext context, double totalCost) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoadedState) {
                return buildCostArea(totalCost);
              }
              return Container();
            },
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 1,
          child: buildPurchase(),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 1,
          child: buildClearList(context),
        ),
      ],
    ),
  );
}

buildClearList(BuildContext context) {
  return MaterialButton(
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
      ));
}

buildPurchase() {
  return MaterialButton(
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
      ));
}

buildCostArea(double totalCost) {
  return Container(
    height: 60,
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
  );
}

void showProductRemoveAlert(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Attention!"),
          content: const Text('Do you want to remove all products?'),
          actions: [
            TextButton(
              child: const Text("No"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text("Yes"),
              onPressed: () {
                context.watch<CartBloc>().add(const ClearCartEvent());
                Navigator.pop(context);
                ScaffoldMessenger.of(context)
                    .showSnackBar(snackbar("All products removed!"));
              },
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        );
      });
}

snackbar(String message) {
  return SnackBar(
    duration: const Duration(milliseconds: 1500),
    content: Align(
        alignment: Alignment.center, heightFactor: 1, child: Text(message)),
    backgroundColor: ThemeConstants.themeColor,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15))),
  );
}

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
