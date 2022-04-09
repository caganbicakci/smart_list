class PurchasedProduct {
  double cost;
  DateTime date;
  String products;

  PurchasedProduct(this.cost, this.date, this.products);

  PurchasedProduct.fromSnapshot(Map map)
      : cost = map['cost'],
        date = map['date'],
        products = map['products'];

  Map toSnapshot() {
    return {
      "cost": cost,
      "purchaseDate": date,
      "products" : products,
    };
  }
}