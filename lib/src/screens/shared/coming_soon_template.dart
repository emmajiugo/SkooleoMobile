import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

class ComingSoonTemplate extends StatelessWidget {
  final Uri _emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'hello@skooleo.com',
  );

  void _launchURL(context) async {
    if (await canLaunch(_emailLaunchUri.toString())) {
      await launch(_emailLaunchUri.toString());
    } else {
      Alert(
        context: context,
        type: AlertType.error,
        title: "ERROR",
        desc: 'Could not launch (${_emailLaunchUri.toString()})',
        buttons: [
          DialogButton(
            child: Text(
              "OKAY",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(
              bottom: 30,
            ),
            child: SvgPicture.asset(
              'assets/svgs/undraw_coming_soon.svg',
              height: 200,
            ),
          ),
          Text(
            'Coming Soon!',
            style: GoogleFonts.openSans(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              color: Colors.purple[900],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text:
                    'We are working to bring this feature to live. While you wait, you can send us feedback to ',
                style: GoogleFonts.openSans(
                  color: Colors.black87,
                  fontSize: 15,
                ),
                children: <TextSpan>[
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => _launchURL(context),
                    text: 'hello@skooleo.com',
                    style: GoogleFonts.openSans(
                      decoration: TextDecoration.underline,
                      color: Colors.blue[900],
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
