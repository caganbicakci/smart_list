import 'package:flutter/material.dart';
import 'package:smart_list/models/product.dart';
import 'package:smart_list/widgets/product_list_row.dart';

class ProductListWidget extends StatefulWidget {
  late List<Product> products;

  ProductListWidget(this.products, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProductListWidgetState();
  }
}

class _ProductListWidgetState extends State<ProductListWidget> {
  @override
  Widget build(BuildContext context) {
    return buildProductList(context);
  }

  Widget buildProductList(BuildContext context) {
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
              children: List.generate(widget.products.length, (index) {
                return ProductListRowWidget(widget.products[index]);
              }),
            ),
          ),
        ),
      ],
    );
  }
}
