import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_list/data/repository/cart_repository.dart';

import '../../models/predicted_product.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepo;
  late List<PredictedProduct>? cartItems;

  // CartBloc(this.cartRepo) : super(CartInitial());

  // Stream<CartState> mapEventToState(CartEvent event) async* {
  //   if (event is CartLoadEvent) {
  //     yield CartLoadingState();
  //     cartItems = await cartRepo
  //         .getPredictedProducts("user_e4cfcc06-799d-40b2-9587-faa832e3b28d");
  //     yield CartLoadedState(cartItems: cartItems!);
  //   } else if (event is RemoveFromCart) {
  //     cartItems!.removeWhere(
  //         (element) => element.productId == event.product.productId);
  //     yield CartLoadedState(cartItems: cartItems!);
  //   } else if (event is ClearCartEvent) {
  //     cartItems = null;
  //     yield CartLoadedState(cartItems: cartItems!);
  //   }
  // }

  // Stream<CartState> _mapCartUpdatedToState(
  //   CartUpdatedEvent event,
  // ) async* {
  //   yield CartLoadingState();
  //   yield CartLoadedState(cartItems: event.products);
  // }

  CartBloc(this.cartRepo) : super(CartLoadingState()) {
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
      emit(CartLoadingState());
      cartItems!.add(event.product);
      emit(CartLoadedState(cartItems: cartItems!));
    });

    on<RemoveFromCart>((event, emit) {
      emit(CartLoadingState());
      cartItems!
          .removeWhere((item) => item.productId == event.product.productId);
      emit(CartLoadedState(cartItems: cartItems!));
    });

    on<ClearCartEvent>((event, emit) {
      emit(CartLoadingState());
      cartItems!.clear();
      emit(CartLoadedState(cartItems: cartItems!));
    });
  }
}
