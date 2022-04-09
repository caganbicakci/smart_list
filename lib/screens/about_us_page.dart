import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
            height: 200,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                constraints: const BoxConstraints.expand(),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/abstract_nn.jpg'),
                        fit: BoxFit.cover)),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Text('ABOUT US',
                      style: GoogleFonts.openSans(
                          fontSize: 38, color: Colors.white)),
                ),
              ),
            ),
          ),
          Positioned(
              right: 0,
              left: 0,
              top: 115,
              height: 300,
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30)),
                    color: Colors.white),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Smart-List \u00a9 Your intelligent grocery list!',
                            style: GoogleFonts.montserrat(fontSize: 17)),
                        Text('Developed by:',
                            style: GoogleFonts.montserrat(fontSize: 17)),
                        const SizedBox(
                          height: 15,
                        ),
                        Text('Ecem ŞEN & Çağan BIÇAKÇI',
                            style: GoogleFonts.notoSans(fontSize: 17)),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/linkedin.png',
                              height: 30,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            RichText(
                                text: TextSpan(
                              text: 'ecemssen',
                              style: GoogleFonts.notoSans(
                                  fontSize: 15, color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  _launchURL(
                                      'https://www.linkedin.com/in/ecem-ssen/');
                                },
                            )),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/linkedin.png',
                              height: 30,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            RichText(
                                text: TextSpan(
                              text: 'caganbicakci',
                              style: GoogleFonts.notoSans(
                                  fontSize: 15, color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  _launchURL(
                                      'https://www.linkedin.com/in/caganbicakci/');
                                },
                            )),
                          ],
                        ),
                      ]),
                ),
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset('assets/images/team.png'),
          ),
        ],
      ),
    );
  }

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
}
