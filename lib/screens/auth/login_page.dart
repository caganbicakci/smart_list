import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

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
  FirebaseAuth auth = FirebaseAuth.instance;

  late User user;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

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
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logos/smart_list_logo.png',
                    height: 125,
                    width: 125,
                  ),
                  const SizedBox(height: 50),
                  buildUsernameField(),
                  const SizedBox(height: 20),
                  buildPasswordField(),
                  buildForgotPasswordField(),
                  // buildRememberMeField(),
                  buildLoginButton(context),
                  // buildGoogleAndFacebookLogin(),
                  buildSignUpArea(),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Column buildGoogleAndFacebookLogin() {
    return Column(
      children: [
        const Text(
          "- OR -",
          style: TextStyle(color: Colors.white),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Sign in with",
          style: TextStyle(color: Colors.white),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage("assets/logos/facebook_logo.png"))),
            ),
            const SizedBox(
              width: 20,
            ),
            Container(
              height: 60,
              width: 60,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage("assets/logos/google_logo.png"),
                  )),
            ),
          ],
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

  buildPasswordField() {
    return Container(
      decoration: kBoxDecorationStyle,
      alignment: Alignment.centerLeft,
      height: 55,
      child: TextField(
          controller: passwordController,
          style: TextStyle(color: Colors.white),
          obscureText: _obscureText,
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
              fillColor: Colors.white,
              contentPadding: EdgeInsets.only(top: 15),
              border: InputBorder.none,
              prefixIcon: const Icon(
                Icons.lock_outline_rounded,
                color: Colors.white,
                size: 21,
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
              hintText: 'Password',
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
            text: "Forgot Password?",
            style: const TextStyle(color: Colors.white),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                Navigator.pushNamed(context, '/password_reset_page');
              }),
      ),
    );
  }

  buildLoginButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.5),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        color: Colors.white,
        padding: const EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Text(
          "LOGIN",
          style:
              TextStyle(color: Colors.black54, letterSpacing: 1, fontSize: 15),
        ),
        onPressed: () async {
          UserCredential userCredential = await auth.signInWithEmailAndPassword(
              email: usernameController.text,
              password: passwordController.text);
          setState(() {
            user = userCredential.user!;
          });
          if (user != null) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
            // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyNavigationBar()));
            FocusScope.of(context).requestFocus(FocusNode());
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
  }

  buildSignUpArea() {
    return Column(
      children: [
        Text(
          "- OR -",
          style: GoogleFonts.openSans(color: Colors.white, fontSize: 16),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 12.5),
          width: double.infinity,
          child: Center(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Don't you have an account? ",
                    style:
                        GoogleFonts.notoSans(fontSize: 14, color: Colors.white),
                  ),
                  TextSpan(
                      text: "Sign up here!",
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
