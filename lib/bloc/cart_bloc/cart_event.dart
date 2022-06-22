part of 'cart_bloc.dart';

abstract class CartEvent {
  const CartEvent();
}

class AddToCart extends CartEvent {
  final Product product;
  const AddToCart({required this.product});
}

class RemoveFromCart extends CartEvent {
  final Product product;
  const RemoveFromCart({required this.product});
}

class CartLoadEvent extends CartEvent {
  const CartLoadEvent();
}

class CartUpdatedEvent extends CartEvent {
  final List<PredictedProduct> products;
  const CartUpdatedEvent({required this.products});
}

class ClearCartEvent extends CartEvent {
  const ClearCartEvent();
}
