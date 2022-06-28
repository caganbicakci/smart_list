import 'package:bloc/bloc.dart';
import 'package:smart_list/constants/arrays.dart';
import 'package:smart_list/data/repository/order_repository.dart';
import 'package:smart_list/models/order.dart';

import '../../models/order_data.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepo;
  late List<Order>? orders;
  OrderBloc(this.orderRepo) : super(OrderInitial()) {
    on<LoadOrdersEvent>((event, emit) async {
      emit(OrderLoading());
      orders = await orderRepo.getOrders();
      emit(OrderLoaded(orders: orders!, orderDataList: getOrderDataList));
    });
  }

  get getOrderDataList {
    Map monthlyExpenses = {};
    List<OrderData> orderDataList = [];

    for (var order in orders!) {
      var price = order.cost.toStringAsFixed(2);
      var month = order.date.month;
      var year = order.date.year;
      if (year == DateTime.now().year) {
        if (monthlyExpenses.containsKey(months[month - 1])) {
          monthlyExpenses[months[month - 1]] += double.parse(price);
        } else {
          monthlyExpenses[months[month - 1]] = double.parse(price);
        }
      }
    }

    monthlyExpenses.forEach((key, value) {
      orderDataList.add(OrderData(key, value));
    });

    return orderDataList;
  }
}
