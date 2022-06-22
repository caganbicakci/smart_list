class Order {
  double cost;
  DateTime date;
  List<dynamic> products;

  Order(this.cost, this.date, this.products);

  Order.fromSnapshot(Map json)
      : cost = json['cost'],
        date = json['date'].toDate(),
        products = json['products'];

  Map toJson() {
    return {
      "cost": cost,
      "date": date,
      "products": products,
    };
  }
}
