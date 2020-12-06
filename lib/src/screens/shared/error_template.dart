import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ErrorTemplate extends StatelessWidget {
  final String message;
  final Function refreshFunction;

  const ErrorTemplate(
      {Key key, @required this.message, @required this.refreshFunction})
      : super(key: key);

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
              'assets/svgs/error.svg',
              height: 200,
            ),
          ),
          Text(
            message,
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: OutlinedButton(
              onPressed: refreshFunction,
              child: Text('Retry!'),
            ),
          ),
        ],
      ),
    );
  }
}
