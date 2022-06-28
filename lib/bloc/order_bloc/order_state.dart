part of 'order_bloc.dart';

abstract class OrderState {
  const OrderState();
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final List<Order> orders;
  final List<OrderData> orderDataList;
  const OrderLoaded({required this.orders, required this.orderDataList});
}

class OrderError extends OrderState {}
