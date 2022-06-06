class PreviousPurchasedProduct {
  double cost;
  String purchaseDate;
  String products;

  PreviousPurchasedProduct(this.cost, this.purchaseDate, this.products);

  PreviousPurchasedProduct.fromSnapshot(Map map)
      : cost = double.parse(map['cost']),
        purchaseDate = map['purchaseDate'],
        products = map['products'];

  Map toSnapshot() {
    return {
      "cost": cost,
      "purchaseDate": purchaseDate,
      "products": products,
    };
  }
}
