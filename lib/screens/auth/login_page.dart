import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_list/bloc/auth_bloc/auth_bloc.dart';
import 'package:smart_list/constants/asset_constants.dart';
import 'package:smart_list/constants/strings.dart';

import '../../constants/theme_constants.dart';
import '../../widgets/background.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State {
  bool rememberMe = false;

  final GlobalKey<FormState> formKey = GlobalKey();

  late User user;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _obscureText = true;

  void _showHidePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const LoginPageBg(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 60,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        SMART_LIST_LOGO,
                        height: 125,
                        width: 125,
                      ),
                      const SizedBox(height: 40),
                      buildUsernameField(),
                      const SizedBox(height: 20),
                      buildPasswordField(),
                      buildForgotPasswordField(),
                      buildLoginButton(context),
                      buildSignUpArea(),
                    ],
                  ),
                )),
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
              hintText: EMAIL_HINT,
              hintStyle: TextStyle(
                color: Colors.white54,
              ))),
    );
  }

  buildPasswordField() {
    return Container(
      decoration: kBoxDecorationStyle,
      alignment: Alignment.centerLeft,
      height: 55,
      child: TextField(
          controller: passwordController,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: Colors.white),
          obscureText: _obscureText,
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.only(top: 15),
              border: InputBorder.none,
              prefixIcon: const Icon(
                Icons.lock_outline_rounded,
                color: Colors.white,
                size: 21,
              ),
              suffixIcon: Container(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  child: _obscureText
                      ? const Icon(
                          Icons.visibility_off,
                          size: 21,
                        )
                      : const Icon(
                          Icons.visibility,
                          size: 21,
                        ),
                  onTap: () {
                    _showHidePassword();
                  },
                ),
              ),
              hintText: PSW_HINT,
              hintStyle: const TextStyle(
                color: Colors.white54,
              ))),
    );
  }

  buildForgotPasswordField() {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.all(15),
      child: RichText(
        text: TextSpan(
            text: FORGOT_PSW,
            style: const TextStyle(color: Colors.white),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                Navigator.pushNamed(context, '/password_reset_page');
              }),
      ),
    );
  }

  buildLoginButton(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 12.5),
          width: double.infinity,
          child: MaterialButton(
            elevation: 5.0,
            color: Colors.white,
            padding: const EdgeInsets.all(15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Text(
              LOGIN_BTN_TEXT,
              style: TextStyle(
                  color: Colors.black54, letterSpacing: 1, fontSize: 15),
            ),
            onPressed: () async {
              BlocProvider.of<AuthBloc>(context).add(
                LoginEvent(
                  email: emailController.text,
                  password: passwordController.text,
                ),
              );
              if (state is Authenticated) {
                Navigator.pushReplacementNamed(context, '/');
                // FocusScope.of(context).requestFocus(FocusNode());
              } else {
                // Toast.show("E-mail or password is wrong!", context,
                //     textColor: Colors.black,
                //     backgroundColor: Colors.white70,
                //     gravity: Toast.CENTER,
                //     duration: Toast.LENGTH_LONG);
              }
            },
          ),
        );
      },
    );
  }

  buildSignUpArea() {
    return Column(
      children: [
        Text(
          OR_SIGN_UP_WITH,
          style: GoogleFonts.openSans(color: Colors.white, fontSize: 16),
        ),
        SizedBox(
          width: double.infinity,
          child: Center(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: DONT_HAVE_ACCOUNT,
                    style:
                        GoogleFonts.notoSans(fontSize: 14, color: Colors.white),
                  ),
                  TextSpan(
                      text: SIGN_UP_HERE,
                      style: GoogleFonts.notoSans(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          Navigator.pushNamed(context, '/sign_up_page');
                        }),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
