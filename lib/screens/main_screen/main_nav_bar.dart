import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import '../../constants/strings.dart';
import '../about_us_page.dart';
import '../home_page.dart';
import '../previous_purchase_page.dart';

import '../../constants/theme_constants.dart';

class MainNavBar extends StatefulWidget {
  const MainNavBar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainNavBarState();
}

class _MainNavBarState extends State {
  var padding = const EdgeInsets.symmetric(horizontal: 18, vertical: 5);
  double gap = 10;
  int _selectedIndex = 0;

  final List<Widget> pageList = [
    const HomePage(),
    const PreviousPurchasePage(),
    const AboutUsPage()
  ];

  List<Color> colors = [
    Colors.deepPurple,
    Colors.teal,
    Colors.pink,
  ];

  List<Text> texts = const [
    Text('Home'),
    Text('Past Purchases'),
    Text('About Us'),
  ];

  PageController controller = PageController();
  FirebaseAuth auth = FirebaseAuth.instance;

  var fabColor;

  void signOut() async {
    await auth.signOut();
    Navigator.of(context).pushNamedAndRemoveUntil(
        '/login_page', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text(
          APP_TITLE,
        ),
        backgroundColor: ThemeConstants.themeColor,
        centerTitle: true,
        actions: [
          MaterialButton(
              onPressed: () {
                showLogoutDialog(context);
              },
              child: const Icon(
                Icons.logout,
                color: Colors.white,
                size: 20,
              )),
        ],
      ),
      floatingActionButton: buildFloatingActionButton(context),
      body: PageView.builder(
          itemCount: colors.length,
          controller: controller,
          onPageChanged: (page) {
            setState(() {
              _selectedIndex = page;
            });
          },
          itemBuilder: (context, position) {
            fabColor = colors[position];
            return pageList[position];
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 45,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(100)),
              boxShadow: [
                BoxShadow(
                  spreadRadius: -10,
                  blurRadius: 60,
                  color: Colors.black.withOpacity(0.4),
                  offset: const Offset(0, 25),
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: GNav(
              curve: Curves.fastOutSlowIn,
              duration: const Duration(milliseconds: 500),
              tabs: [
                buildGButton(HOME, LineIcons.home, Colors.deepPurple),
                buildGButton(PAST_PURCHASES, LineIcons.heart, Colors.teal),
                buildGButton(ABOUT_US, LineIcons.infoCircle, Colors.pink),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
                controller.jumpToPage(index);
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> showLogoutDialog(BuildContext context) {
    return showDialog(
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(ATTENTION),
            content: const Text(SIGN_OUT_MESSAGE),
            actions: [
              TextButton(
                child: const Text(NO),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text(YES),
                onPressed: () {
                  signOut();
                  Navigator.of(context).pushReplacementNamed('/login_page');
                },
              ),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          );
        },
        context: context);
  }

  GButton buildGButton(String text, IconData icon, Color color) {
    return GButton(
      gap: gap,
      padding: padding,
      icon: icon,
      iconColor: Colors.black,
      iconActiveColor: color,
      text: text,
      textColor: color,
      backgroundColor: color.withOpacity(0.2),
      iconSize: 24,
    );
  }

  buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.list_alt),
      backgroundColor: fabColor,
      onPressed: () {
        Navigator.pushNamed(context, '/cart');
      },
    );
  }
}
