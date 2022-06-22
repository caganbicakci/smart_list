import 'package:bloc/bloc.dart';
import 'package:smart_list/data/repository/order_repository.dart';
import 'package:smart_list/models/order.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepo;
  late List<Order>? orders;
  OrderBloc(this.orderRepo) : super(OrderInitial()) {
    on<LoadOrdersEvent>((event, emit) async {
      emit(OrderLoading());
      orders = await orderRepo.getOrders();
      emit(OrderLoaded(orders: orders!));
      print(orders);
    });
  }
}
