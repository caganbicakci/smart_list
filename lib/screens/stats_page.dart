import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_list/constants/strings.dart';
import 'package:smart_list/constants/theme_constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

import '../bloc/order_bloc/order_bloc.dart';
import '../models/order.dart';
import '../models/order_data.dart';

class StatsPage extends StatefulWidget {
  StatsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  var temp = List.generate(12, (index) {
    var sum = (DateTime.now().month - index + 12);
    if (sum != 12) {
      return sum % 12;
    } else {
      return sum;
    }
  }).reversed;

  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Stats'),
          backgroundColor: ThemeConstants.themeColor,
          centerTitle: true,
        ),
        body: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state is OrderLoaded) {
              return Center(
                  child: Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.9,
                width: MediaQuery.of(context).size.width * 0.8,
                child: SfCartesianChart(
                  title: ChartTitle(text: MONTHLY_EXPENSES),
                  legend: Legend(isVisible: true),
                  tooltipBehavior: _tooltipBehavior,
                  series: <ChartSeries>[
                    BarSeries<OrderData, String>(
                        name: DateTime.now().year.toString(),
                        dataSource: state.orderDataList,
                        xValueMapper: (OrderData sales, _) => sales.month,
                        yValueMapper: (OrderData sales, _) => sales.cost,
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: false),
                        enableTooltip: true,
                        color: Colors.green)
                  ],
                  primaryXAxis: CategoryAxis(),
                  primaryYAxis: NumericAxis(
                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                    numberFormat:
                        NumberFormat.currency(locale: TR, symbol: TL_SYMBOL),
                  ),
                ),
              ));
            } else {
              return Container();
            }
          },
        ));
  }
}
