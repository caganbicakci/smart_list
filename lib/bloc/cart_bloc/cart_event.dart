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
  CartLoadEvent();
}

class CartUpdatedEvent extends CartEvent {
  final List<Product> products;
  const CartUpdatedEvent({required this.products});
}

class ClearCartEvent extends CartEvent {
  const ClearCartEvent();
}

class PurchaseEvent extends CartEvent {
  final List<Product> purchasedProducts;
  final DateTime purchaseDate;
  final double totalCost;
  const PurchaseEvent(
      {required this.purchasedProducts,
      required this.purchaseDate,
      required this.totalCost});
}
