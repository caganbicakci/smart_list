import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/repository/cart_repository.dart';
import '../../models/product.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepo;
  late List<Product>? cartItems;

  CartBloc(this.cartRepo) : super(CartLoadingState()) {
    on<CartLoadEvent>((event, emit) async {
      emit(CartLoadingState());
      cartItems = await cartRepo.getCartItems();
      if (cartItems != null) {
        emit(CartLoadedState(cartItems: cartItems!, totalCost: getTotalCost()));
      } else {
        emit(CartErrorState());
      }
    });

    on<AddToCart>((event, emit) {
      emit(CartLoadingState());
      cartItems!.add(event.product);
      emit(CartLoadedState(cartItems: cartItems!, totalCost: getTotalCost()));
    });

    on<RemoveFromCart>((event, emit) {
      emit(CartLoadingState());
      cartItems!
          .removeWhere((item) => item.productId == event.product.productId);
      emit(CartLoadedState(cartItems: cartItems!, totalCost: getTotalCost()));
    });

    on<ClearCartEvent>((event, emit) {
      emit(CartLoadingState());
      cartItems!.clear();
      emit(CartEmptyState());
    });

    on<PurchaseEvent>((event, emit) async {
      List<Map> productMapList = [];
      for (var product in event.purchasedProducts) {
        productMapList.add(product.toJson());
      }

      await cartRepo.submitPurchase(
          date: event.purchaseDate,
          cost: event.totalCost,
          products: productMapList);

      cartItems!.clear();
      emit(CartEmptyState());
    });
  }

  double getTotalCost() {
    var totalCost = 0.0;
    for (var item in cartItems!) {
      totalCost += item.price;
    }
    return totalCost;
  }

  String getCurrentUserEmail() {
    return FirebaseAuth.instance.currentUser!.email!;
  }
}
