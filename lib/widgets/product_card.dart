import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_list/bloc/cart_bloc/cart_bloc.dart';
import '../constants/theme_constants.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard(this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Stack(
        children: [
          Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    child: Image.network(
                      product.imageUrl,
                    ),
                    height: 100.0,
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    product.productName,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    product.quantityPerUnit.toString(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              )),
          Positioned(
            right: 0,
            top: 0,
            child: Center(
              child: InkWell(
                onTap: () {
                  context.read<CartBloc>().add(AddToCart(product: product));
                },
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  decoration: BoxDecoration(
                      color: ThemeConstants.cardColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                            color: ThemeConstants.themeColor, blurRadius: 1)
                      ]),
                  height: 30,
                  width: 30,
                  child: const Icon(
                    Icons.add,
                    color: ThemeConstants.themeColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
