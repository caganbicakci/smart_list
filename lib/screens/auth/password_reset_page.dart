import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../widgets/background.dart';

class PasswordResetPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PasswordResetPageState();
  }
}

class _PasswordResetPageState extends State {
  FirebaseAuth auth = FirebaseAuth.instance;

  final usernameController = TextEditingController();

  final kBoxDecorationStyle = BoxDecoration(
    borderRadius: BorderRadius.circular(30.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 1.0,
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        LoginPageBg(),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              // height: double.infinity,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 60,
                ),
                child: Stack(children: [
                  GestureDetector(
                    child: Icon(
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
                        'assets/logos/smart_list_logo.png',
                        height: 125,
                        width: 125,
                      ),
                      SizedBox(height: 60),
                      buildUsernameField(),
                      SizedBox(height: 20),
                      // buildRememberMeField(),
                      buildResetPasswordButton(context),
                      // buildGoogleAndFacebookLogin(),
                    ],
                  ),
                ]),
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
          style: TextStyle(color: Colors.white),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 15),
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.account_circle_rounded,
                color: Colors.white,
              ),
              hintText: 'Enter an e-mail to reset password',
              hintStyle: TextStyle(
                color: Colors.white54,
              ))),
    );
  }

  buildResetPasswordButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.5),
      width: double.infinity,
      child: RaisedButton(
          elevation: 5.0,
          color: Colors.white,
          padding: EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            "SEND RESET EMAIL",
            style: TextStyle(
                color: Colors.black54, letterSpacing: 1, fontSize: 15),
          ),
          onPressed: () async {
            auth.sendPasswordResetEmail(email: usernameController.text);
            // Toast.show("Pasword reset e-mail sended!", context,
            //     textColor: Colors.black,
            //     backgroundColor: Colors.white70,
            //     gravity: Toast.CENTER,
            //     duration: Toast.LENGTH_LONG);
          }),
    );
  }
}
