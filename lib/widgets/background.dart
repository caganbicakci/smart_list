import 'package:flutter/material.dart';

class LoginPageBg extends StatelessWidget {
  const LoginPageBg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
            colors: [
              Colors.purple,
              Colors.blueAccent,
            ]),
      ),
    );
  }
}
