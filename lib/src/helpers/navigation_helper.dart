import 'package:flutter/material.dart';

class NavigationHelper {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  // Future<dynamic> pushNamed(String routeName) {
  //   return navigatorKey.currentState.pushNamed(routeName);
  // }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName) {
    return navigatorKey.currentState
        .pushNamedAndRemoveUntil(routeName, (route) => false);
  }

  // bool goBack() {
  //   return navigatorKey.currentState.pop();
  // }
}
