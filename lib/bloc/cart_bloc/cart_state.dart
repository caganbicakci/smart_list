part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();
  @override
  List<Object> get props => [];
}

class CartLoadingState extends CartState {}

class CartLoadedState extends CartState {
  final List<Product> cartItems;
  final double totalCost;
  const CartLoadedState({required this.cartItems, required this.totalCost});

  @override
  List<Object> get props => [cartItems, totalCost];
}

class CartErrorState extends CartState {}

class CartEmptyState extends CartState {}
