part of 'cart_bloc.dart';

abstract class CartEvent {
  const CartEvent();
}

class AddToCart extends CartEvent {
  final PredictedProduct product;
  const AddToCart({required this.product});
}

class RemoveFromCart extends CartEvent {
  final PredictedProduct product;
  const RemoveFromCart({required this.product});
}

class CartLoadEvent extends CartEvent {
  final String userId;
  const CartLoadEvent({required this.userId});
}
