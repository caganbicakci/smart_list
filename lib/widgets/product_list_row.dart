import 'package:flutter/material.dart';
import 'package:smart_list/constants/constants.dart';
import 'package:smart_list/models/product.dart';

class ProductListRowWidget extends StatefulWidget {
  Product product;
  ProductListRowWidget(this.product, {Key? key}) : super(key: key);

  @override
  _ProductListRowWidgetState createState() => _ProductListRowWidgetState();
}

class _ProductListRowWidgetState extends State<ProductListRowWidget> {
  @override
  Widget build(BuildContext context) {
    return buildProductItemCard(context);
  }

  Widget buildProductItemCard(BuildContext context) {
    return Stack(
      children: [
        Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: Image.network(
                    widget.product.imageUrl,
                  ),
                  height: 100.0,
                  width: MediaQuery.of(context).size.width / 2,
                  padding: EdgeInsets.all(5),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.product.productName,
                  style: const TextStyle(fontSize: 13, color: Colors.black87),
                ),
                Text(
                  widget.product.quantityPerUnit.toString(),
                  style: const TextStyle(fontSize: 14, color: Colors.black45),
                ),
              ],
            )),
        Positioned(
          right: 0,
          top: 0,
          child: Center(
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                    boxShadow: [
                      BoxShadow(color: Constants.themeColor, blurRadius: 1)
                    ]),
                height: 30,
                width: 30,
                child: Icon(
                  Icons.add,
                  color: Constants.themeColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
