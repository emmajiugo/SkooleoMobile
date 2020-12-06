import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyScreenTemplate extends StatelessWidget {
  final String message;

  const EmptyScreenTemplate({Key key, @required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 30,
              ),
              child: SvgPicture.asset(
                'assets/svgs/undraw_no_data.svg',
                height: 200,
              ),
            ),
            Text(
              message?.toUpperCase(),
              style: GoogleFonts.openSans(
                fontSize: 17,
                fontWeight: FontWeight.w900,
                color: Colors.pink[900],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
