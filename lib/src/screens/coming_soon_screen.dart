import 'package:flutter/material.dart';
import 'package:skooleo/src/screens/shared/coming_soon_template.dart';

class ComingSoonScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coming Soon!'),
      ),
      body: ComingSoonTemplate(),
    );
  }
}
