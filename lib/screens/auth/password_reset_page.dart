import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_list/constants/asset_constants.dart';
import 'package:smart_list/constants/strings.dart';
import 'package:toast/toast.dart';

import '../../constants/theme_constants.dart';
import '../../widgets/background.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PasswordResetPageState();
  }
}

class _PasswordResetPageState extends State {
  FirebaseAuth auth = FirebaseAuth.instance;

  final usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const LoginPageBg(),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 60,
              ),
              child: Stack(children: [
                GestureDetector(
                  child: const Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      SMART_LIST_LOGO,
                      height: 125,
                      width: 125,
                    ),
                    const SizedBox(height: 60),
                    buildUsernameField(),
                    const SizedBox(height: 20),
                    buildResetPasswordButton(context),
                  ],
                ),
              ]),
            ),
          ),
        )
      ],
    );
  }

  buildUsernameField() {
    return Container(
      decoration: kBoxDecorationStyle,
      alignment: Alignment.centerLeft,
      height: 55,
      child: TextField(
          controller: usernameController,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: Colors.white),
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(top: 15),
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.account_circle_rounded,
                color: Colors.white,
              ),
              hintText: PSW_RESET_HINT,
              hintStyle: TextStyle(
                color: Colors.white54,
              ))),
    );
  }

  buildResetPasswordButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.5),
      width: double.infinity,
      child: RaisedButton(
          elevation: 5.0,
          color: Colors.white,
          padding: const EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Text(
            PSW_RESET_BTN_TEXT,
            style: TextStyle(
                color: Colors.black54, letterSpacing: 1, fontSize: 15),
          ),
          onPressed: () async {
            auth.sendPasswordResetEmail(email: usernameController.text);
            Toast.show("Pasword reset e-mail sended!",
                webTexColor: Colors.black,
                backgroundColor: Colors.white70,
                gravity: 1,
                duration: 3);
          }),
    );
  }
}
