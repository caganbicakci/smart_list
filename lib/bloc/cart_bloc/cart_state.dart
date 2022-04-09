part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();
  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoadingState extends CartState {}

class CartLoadedState extends CartState {
  final List<PredictedProduct> cartItems;
  const CartLoadedState({required this.cartItems});

  @override
  List<Object> get props => cartItems;
}

class CartErrorState extends CartState {}
