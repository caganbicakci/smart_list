import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_list/bloc/auth_bloc/auth_bloc.dart';
import '../../constants/asset_constants.dart';
import '../../constants/strings.dart';
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
  // FirebaseAuth auth = FirebaseAuth.instance;

  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const LoginPageBg(),
        SafeArea(
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backwardsCompatibility: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 60,
              ),
              child: Column(
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
          controller: emailController,
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
            BlocProvider.of<AuthBloc>(context, listen: false)
                .add(PasswordResetEvent(email: emailController.text));
            // auth.sendPasswordResetEmail(email: emailController.text);
            Toast.show(PSW_RESET_SUCCESS,
                webTexColor: Colors.black,
                backgroundColor: Colors.white70,
                gravity: 1,
                duration: 3);
          }),
    );
  }
}
