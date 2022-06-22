part of 'order_bloc.dart';

abstract class OrderEvent {
  const OrderEvent();
}

class LoadOrdersEvent extends OrderEvent {}
