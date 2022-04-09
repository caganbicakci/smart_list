// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:smart_list/constants/constants.dart';
// import 'package:smart_list/models/previous_purchased_products.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:intl/intl.dart';

// class StatsPage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _StatsPageState();
// }

// class _StatsPageState extends State {
//   var months = [
//     'Jan',
//     'Feb',
//     'Mar',
//     'Apr',
//     'May',
//     'Jun',
//     'Jul',
//     'Aug',
//     'Sep',
//     'Oct',
//     'Nov',
//     'Dec'
//   ];

//   FirebaseAuth auth = FirebaseAuth.instance;

//   // List<_SalesData> chartDataList = [];
//   List<double> costs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

//   List<PreviousPurchasedProduct> purchasedProducts = [];

//   late TooltipBehavior _tooltipBehavior;

//   @override
//   void initState() {
//     _tooltipBehavior = TooltipBehavior(enable: true);
//     // getPurchaseData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           title: const Text('Stats'),
//           backgroundColor: Constants.themeColor,
//           centerTitle: true,
//         ),
//         body: Center(
//             child: Container(
//           color: Colors.white,
//           height: MediaQuery.of(context).size.height * 0.9,
//           width: MediaQuery.of(context).size.width * 0.8,
//           child: SfCartesianChart(
//             title: ChartTitle(text: 'Monthly Expenses'),
//             legend: Legend(isVisible: true),
//             tooltipBehavior: _tooltipBehavior,
//             // series: <ChartSeries>[
//             //   BarSeries<_SalesData, String>(
//             //       name: '2021',
//             //       // dataSource: getChartData(),
//             //       // xValueMapper: (_SalesData sales, _) => sales.month,
//             //       // yValueMapper: (_SalesData sales, _) => sales.cost,
//             //       dataLabelSettings: DataLabelSettings(isVisible: false),
//             //       enableTooltip: true,
//             //       color: Colors.green)
//             // ],
//             primaryXAxis: CategoryAxis(),
//             primaryYAxis: NumericAxis(
//               edgeLabelPlacement: EdgeLabelPlacement.shift,
//               numberFormat: NumberFormat.currency(locale: 'tr', symbol: '₺'),
//             ),
//           ),
//         )));
//   }

//   // getPurchaseData() async {
//   //   User? user = auth.currentUser;
//   //   setState(() {
//   //     DatabaseService.getPurchasedProducts(user!.uid).then((snapshot) {
//   //       var keys = snapshot.value.keys;
//   //       var data = snapshot.value;

//   //       purchasedProducts.clear();

//   //       for (var key in keys) {
//   //         PreviousPurchasedProduct _product = new PreviousPurchasedProduct(
//   //           double.parse(data[key]['cost'].toString()),
//   //           data[key]['purchaseDate'],
//   //           data[key]['products'],
//   //         );

//   //         setState(() {
//   //           var tempPrice = _product.cost;
//   //           var tempMonth = _product.purchaseDate.substring(3, 5);
//   //           var tempYear = _product.purchaseDate.substring(6, 10);
//   //           purchasedProducts.add(_product);

//   //           if (tempYear == DateTime.now().year.toString()) {
//   //             if (tempMonth.startsWith('0')) {
//   //               costs[int.parse(tempMonth.substring(1, 2)) - 1] += tempPrice;
//   //             } else {
//   //               costs[int.parse(tempMonth) - 1] += tempPrice;
//   //             }
//   //           }
//   //         });
//   //       }
//   //     });
//   //   });
//   // }

//   // List<_SalesData> getChartData() {
//   //   setState(() {
//   //     for (int i = 0; i < costs.length; i++) {
//   //       chartDataList.add(_SalesData(months[i], costs[i]));
//   //     }
//   //   });
//   //   return chartDataList;
//   // }
// }

// // class _SalesData {
// //   String month;
// //   double cost;
// //   _SalesData(this.month, this.cost);
// // }
