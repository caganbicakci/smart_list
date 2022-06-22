import 'package:flutter/material.dart';

class ThemeConstants {
  static const themeColor = Color.fromRGBO(15, 30, 179, 100);
  static const cardColor = Colors.white;
}

final kBoxDecorationStyle = BoxDecoration(
  borderRadius: BorderRadius.circular(30.0),
  boxShadow: const [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 1.0,
    ),
  ],
);

const bgDecorationStyle = BoxDecoration(
    image: DecorationImage(
        image: AssetImage('assets/images/bg1.jpg'), fit: BoxFit.cover));
