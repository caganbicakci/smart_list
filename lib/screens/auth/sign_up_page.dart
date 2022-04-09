import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../widgets/background.dart';

class SignUpPage extends StatefulWidget {
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

  final kBoxDecorationStyle = BoxDecoration(
    borderRadius: BorderRadius.circular(30.0),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 1.0,
      ),
    ],
  );

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
            body: Container(
              // height: double.infinity,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 60,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/logos/smart_list_logo.png',
                      height: 125,
                      width: 125,
                    ),
                    SizedBox(height: 50),
                    buildUsernameField(),
                    SizedBox(height: 20),
                    buildPasswordField(passwordController1, 'Password'),
                    SizedBox(height: 20),
                    buildPasswordField(passwordController2, 'Password Again'),
                    // buildGoogleAndFacebookLogin(),
                    buildSignUpBtn(),
                  ],
                ),
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
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(top: 15),
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.account_circle_rounded,
                color: Colors.white,
              ),
              hintText: 'Email',
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
          style: const TextStyle(color: Colors.white),
          obscureText: _obscureText,
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
              fillColor: Colors.white,
              contentPadding: EdgeInsets.only(top: 15),
              border: InputBorder.none,
              prefixIcon: const Icon(
                Icons.lock_outlined,
                size: 21,
                color: Colors.white,
              ),
              suffixIcon: Container(
                padding: EdgeInsets.only(right: 10),
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
      child: MaterialButton(
        elevation: 5.0,
        color: Colors.white,
        padding: const EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Text(
          "SIGN UP",
          style:
              TextStyle(color: Colors.black54, letterSpacing: 1, fontSize: 15),
        ),
        onPressed: () async {
          if (usernameController.text.isNotEmpty &&
              passwordController1.text == passwordController2.text &&
              passwordController1.text != "" &&
              passwordController2.text != "") {
            try {
              await auth.createUserWithEmailAndPassword(
                  email: usernameController.text,
                  password: passwordController1.text);
              FocusScope.of(context).requestFocus(FocusNode());
              Navigator.pop(context);
            } catch (ex) {
              // showSignUpError(ex.toString());
            }
          } else {
            // showSignUpError("Please check e-mail or password!");
          }
        },
      ),
    );
  }
}
