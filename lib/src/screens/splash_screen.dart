import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Image.asset(
            'assets/logos/skooleo_logo2.png',
            height: 200,
            width: 200,
          ),
        ),
      ),
    );
  }
}
