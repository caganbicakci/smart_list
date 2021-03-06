import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/auth_bloc/auth_bloc.dart';

import 'bloc/order_bloc/order_bloc.dart';
import 'bloc/product_bloc/product_bloc.dart';
import 'constants/strings.dart';
import 'data/repository/order_repository.dart';
import 'data/repository/product_repositroy.dart';
import 'router/app_router.dart';
import 'bloc/cart_bloc/cart_bloc.dart';

import 'package:firebase_core/firebase_core.dart';
import 'data/repository/cart_repository.dart';
import 'services/auth/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductBloc(ProductRepository()),
        ),
        BlocProvider(
          create: (context) => CartBloc(CartRepository()),
        ),
        BlocProvider(
          create: (context) => AuthBloc(AuthService()),
        ),
        BlocProvider(
          create: (context) => OrderBloc(OrderRepository()),
        ),
      ],
      child: MaterialApp(
        title: APP_TITLE,
        debugShowCheckedModeBanner: false,
        initialRoute: '/login_page',
        onGenerateRoute: _appRouter.onGenerateRoute,
      ),
    );
  }
}
