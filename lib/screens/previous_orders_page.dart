import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_list/bloc/order_bloc/order_bloc.dart';
import 'package:smart_list/constants/strings.dart';
import 'package:smart_list/constants/theme_constants.dart';
import 'package:smart_list/models/order.dart';
import 'package:smart_list/widgets/custom_button.dart';

import '../models/product.dart';

class PreviousOrdersPage extends StatefulWidget {
  PreviousOrdersPage({Key? key}) : super(key: key);

  List<Order> orders = [];

  @override
  State<StatefulWidget> createState() => _PreviousOrdersPage();
}

class _PreviousOrdersPage extends State<PreviousOrdersPage> {
  @override
  void initState() {
    context.read<OrderBloc>().add(LoadOrdersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: bgDecorationStyle,
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state is OrderLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is OrderError) {
              return const Center(child: Text(SOMETHING_WENT_WRONG));
            }
            if (state is OrderLoaded) {
              widget.orders = state.orders;

              return Container(
                  padding: EdgeInsets.fromLTRB(
                      15, 15, 15, MediaQuery.of(context).size.height * 0.09),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 9,
                        child: ListView.builder(
                            itemCount: widget.orders.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.all(5),
                                child: ExpansionTileCard(
                                  baseColor: Colors.white70,
                                  shadowColor: Colors.white70,
                                  expandedColor: Colors.white70,
                                  title: Row(
                                    children: [
                                      Text(DateFormat('d MMMM y - HH:mm')
                                          .format(widget.orders[index].date)
                                          .toString()),
                                      Expanded(
                                          child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(widget
                                                      .orders[index].cost
                                                      .toStringAsFixed(2) +
                                                  TL_CURRENCY)))
                                    ],
                                  ),
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, top: 15),
                                        child: buildOrderList(context,
                                            widget.orders[index].products),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            title: SHOW_GRAPHS,
                            function: () {
                              Navigator.pushNamed(context, '/stats_page');
                            },
                          ),
                        ),
                      ),
                    ],
                  ));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  buildOrderList(BuildContext context, List<dynamic> orders) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.white70,
              shadowColor: Colors.white70,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${Product.fromJson(orders[index]).quantity} - "),
                    Expanded(
                      child: Text(
                        Product.fromJson(orders[index]).productName,
                        softWrap: false,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                        "${Product.fromJson(orders[index]).price} $TL_CURRENCY"),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
