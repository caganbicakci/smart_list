import 'package:flutter/material.dart';
import '../screens/auth/password_reset_page.dart';
import '../screens/cart_page.dart';
import '../screens/main_screen/main_screen.dart';

import '../screens/auth/login_page.dart';
import '../screens/auth/sign_up_page.dart';
import '../screens/previous_orders_page.dart';

class AppRouter {
  MaterialPageRoute? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => MainScreen(),
        );
      case '/login_page':
        return MaterialPageRoute(
          builder: (_) => LoginPage(),
        );
      case '/sign_up_page':
        return MaterialPageRoute(
          builder: (_) => SignUpPage(),
        );
      case '/cart':
        return MaterialPageRoute(
          builder: (_) => MyCart(),
        );
      case '/previous_purchase_page':
        return MaterialPageRoute(
          builder: (_) => PreviousOrdersPage(),
        );
      case '/password_reset_page':
        return MaterialPageRoute(
          builder: (_) => PasswordResetPage(),
        );
      default:
        return null;
    }
  }
}
