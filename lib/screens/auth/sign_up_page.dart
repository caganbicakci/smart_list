import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/asset_constants.dart';
import '../../constants/strings.dart';

import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../constants/theme_constants.dart';
import '../../widgets/background.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SignUpPageState();
  }
}

class _SignUpPageState extends State {
  bool rememberMe = false;
  FirebaseAuth auth = FirebaseAuth.instance;

  late User user;

  final usernameController = TextEditingController();
  final passwordController1 = TextEditingController();
  final passwordController2 = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController1.dispose();
    passwordController2.dispose();
    super.dispose();
  }

  bool _obscureText = true;

  void _showHidePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

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
                  const SizedBox(height: 50),
                  buildUsernameField(),
                  const SizedBox(height: 20),
                  buildPasswordField(passwordController1, PSW_HINT),
                  const SizedBox(height: 20),
                  buildPasswordField(passwordController2, PSW_HINT_2),
                  // buildGoogleAndFacebookLogin(),
                  buildSignUpBtn(),
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
              hintText: EMAIL_HINT,
              hintStyle: TextStyle(
                color: Colors.white54,
              ))),
    );
  }

  buildPasswordField(TextEditingController _controller, String hintText) {
    return Container(
      decoration: kBoxDecorationStyle,
      alignment: Alignment.centerLeft,
      height: 55,
      child: TextField(
          controller: _controller,
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
                Icons.lock_outlined,
                size: 21,
                color: Colors.white,
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
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Colors.white54,
              ))),
    );
  }

  buildSignUpBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      width: double.infinity,
      child: SizedBox(
        height: 50,
        child: MaterialButton(
          elevation: 5.0,
          color: Colors.white,
          padding: const EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error.toString())));
            }
            if (state is Authenticated) {
              Navigator.pushReplacementNamed(context, '/');
            }
          }, builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                ),
              );
            }
            return const Text(
              SIGN_UP_BTN_TEXT,
              style: TextStyle(
                  color: Colors.black54, letterSpacing: 1, fontSize: 15),
            );
          }),
          onPressed: () async {
            BlocProvider.of<AuthBloc>(context, listen: false).add(
              SignUpEvent(
                  email: usernameController.text,
                  password1: passwordController1.text,
                  password2: passwordController2.text),
            );
          },
        ),
      ),
    );
  }
}
