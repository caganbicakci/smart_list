import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_list/data/repository/cart_repository.dart';

import '../../models/predicted_product.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartRepository cartRepo;
  late List<PredictedProduct>? cartItems;

  CartBloc(this.cartRepo) : super(CartInitial()) {
    on<CartLoadEvent>((event, emit) async {
      emit(CartLoadingState());
      cartItems = await cartRepo.getPredictedProducts(event.userId);
      if (cartItems != null) {
        emit(CartLoadedState(cartItems: cartItems!));
      } else {
        emit(CartErrorState());
      }
    });

    on<AddToCart>((event, emit) {
      cartItems!.add(event.product);
    });

    on<RemoveFromCart>((event, emit) {
      cartItems!
          .removeWhere((item) => item.productId == event.product.productId);
    });
  }
}
