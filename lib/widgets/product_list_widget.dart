import 'package:flutter/material.dart';
import 'package:smart_list/models/product.dart';
import 'package:smart_list/widgets/product_card.dart';

class ProductListWidget extends StatelessWidget {
  final List<Product> products;
  const ProductListWidget({required this.products, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 10.0),
        SizedBox(
          height: MediaQuery.of(context).size.height - 205,
          child: Scrollbar(
            thickness: 2,
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              children: List.generate(products.length, (index) {
                return ProductCard(products[index]);
              }),
            ),
          ),
        ),
      ],
    );
  }
}
