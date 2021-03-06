import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_list/constants/asset_constants.dart';
import 'package:smart_list/constants/strings.dart';
import 'package:smart_list/widgets/custom_button.dart';
import '../constants/theme_constants.dart';

import '../bloc/cart_bloc/cart_bloc.dart';
import '../models/product.dart';

class MyCart extends StatefulWidget {
  MyCart({Key? key}) : super(key: key);

  List<Product> products = [];
  double totalCost = 0.0;

  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            APP_TITLE,
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
          decoration: bgDecorationStyle,
          child: BlocConsumer<CartBloc, CartState>(
            listener: ((context, state) {
              if (widget.products.isEmpty) {
                context.read<CartBloc>().emit(CartEmptyState());
              }
            }),
            builder: (context, state) {
              if (state is CartLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is CartLoadedState) {
                widget.products = state.cartItems;
                widget.totalCost = widget.products
                    .fold(0.0, (prev, element) => prev + element.price);

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
                                  "${widget.products[index].price.toStringAsFixed(2)} $TL_CURRENCY",
                                )),
                          ),
                        ),
                      ),
                    ),
                    purchasedArea(context, widget.products, widget.totalCost),
                  ],
                );
              }
              if (state is CartErrorState) {
                return const Center(
                  child: Text(SOMETHING_WENT_WRONG),
                );
              }

              if (state is CartEmptyState) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                          height: 200,
                          width: 200,
                          child: Lottie.asset(EMPTY_CART_ANIMATION,
                              repeat: false)),
                      Text(
                        CART_IS_EMPTY,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 20, color: Colors.white),
                      ),
                      CustomButton(
                          title: BACK_BTN_TEXT,
                          function: () {
                            Navigator.pop(context);
                          })
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ));
  }
}

Widget purchasedArea(
    BuildContext context, List<Product> products, double totalCost) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      children: [
        Expanded(
            flex: 3,
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  "${totalCost.toStringAsFixed(2)} TL",
                  style: const TextStyle(fontSize: 15),
                ),
              ),
            )),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 1,
          child: buildPurchase(context, products, totalCost),
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
        showProductRemoveAlert(context);
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

buildPurchase(BuildContext context, List<Product> products, double totalCost) {
  return MaterialButton(
      height: 60,
      onPressed: () async {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return savePurchaseAlert(context, products, totalCost);
            });
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

void showProductRemoveAlert(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(ATTENTION),
          content: const Text(REMOVE_PRODUCTS_QUESTION),
          actions: [
            TextButton(
              child: const Text(NO),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text(YES),
              onPressed: () {
                context.read<CartBloc>().add(const ClearCartEvent());
                Navigator.pop(context);
                ScaffoldMessenger.of(context)
                    .showSnackBar(snackbar(PRODUCTS_REMOVED));
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
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(5),
      topRight: Radius.circular(5),
    )),
  );
}

Widget savePurchaseAlert(
    BuildContext context, List<Product> products, double totalCost) {
  var _date = DateTime.now();
  return AlertDialog(
    contentPadding: EdgeInsets.zero,
    content: SizedBox(
      height: 250,
      width: MediaQuery.of(context).size.width - 10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Wrap(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      '$TOTAL_COST: ${totalCost.toStringAsFixed(2)} $TL_CURRENCY',
                      style: GoogleFonts.openSans(
                          fontSize: 18, color: Colors.blueGrey),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    height: 100,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: DateTime.now(),
                      maximumYear: DateTime.now().year,
                      onDateTimeChanged: (DateTime newDateTime) {
                        _date = newDateTime;
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: MaterialButton(
              padding: EdgeInsets.zero,
              color: Colors.green,
              minWidth: MediaQuery.of(context).size.width - 10,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              child: Text(
                SAVE,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.white,
                    ),
              ),
              onPressed: () {
                context.read<CartBloc>().add(PurchaseEvent(
                    purchasedProducts: products,
                    purchaseDate: _date,
                    totalCost: totalCost));
                context.read<CartBloc>().add(const ClearCartEvent());
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  );
}
