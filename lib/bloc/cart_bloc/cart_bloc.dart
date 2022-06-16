import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/repository/cart_repository.dart';

import '../../models/predicted_product.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepo;
  late List<PredictedProduct>? cartItems;

  CartBloc(this.cartRepo) : super(CartLoadingState()) {
    on<CartLoadEvent>((event, emit) async {
      emit(CartLoadingState());
      cartItems = await cartRepo.getPredictedProducts(event.userId);
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
      emit(CartLoadedState(cartItems: cartItems!, totalCost: getTotalCost()));
    });
  }

  double getTotalCost() {
    var totalCost = 0.0;
    for (var item in cartItems!) {
      totalCost += item.price;
    }
    return totalCost;
  }
}
