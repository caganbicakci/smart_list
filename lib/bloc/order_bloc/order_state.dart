part of 'order_bloc.dart';

abstract class OrderState {
  const OrderState();
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final List<Order> orders;
  const OrderLoaded({required this.orders});
}
