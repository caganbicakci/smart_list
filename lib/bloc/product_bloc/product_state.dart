part of 'product_bloc.dart';

abstract class ProductState {
  const ProductState();
}

class ProductInitial extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductLoadedState extends ProductState {
  final List<Product> products;
  final List<Category> categories;
  const ProductLoadedState({required this.products, required this.categories});
}

class ProductByCategoryLoadedState extends ProductState {
  final List<Product> products;
  final List<Category> categories;
  const ProductByCategoryLoadedState(
      {required this.products, required this.categories});
}

class ProductErrorState extends ProductState {}
