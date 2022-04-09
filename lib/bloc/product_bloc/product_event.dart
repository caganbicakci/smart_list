part of 'product_bloc.dart';

abstract class ProductEvent {
  const ProductEvent();
}

class ProductLoadEvent extends ProductEvent {}

class LoadProductByCategory extends ProductEvent {
  final int categoryId;
  LoadProductByCategory({required this.categoryId});
}
