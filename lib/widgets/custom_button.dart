// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({Key? key, required this.title, required this.function})
      : super(key: key);
  String title;
  VoidCallback function;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        elevation: 5.0,
        color: Colors.white,
        padding: const EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: Colors.black54,
                letterSpacing: 1,
                fontSize: 15,
              ),
        ),
        onPressed: function);
  }
}
