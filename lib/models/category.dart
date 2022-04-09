class Category {
  Category({
    required this.categoryId,
    required this.categoryName,
  });

  int categoryId;
  String categoryName;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
      );

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "categoryName": categoryName,
      };
}
