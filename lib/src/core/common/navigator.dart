import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Navigation {
  static intentWithData(String routeName, {Object? arguments}) {
    navigatorKey.currentState
        ?.pushReplacementNamed(routeName, arguments: arguments);
  }

  static navigateToPageReplacement(String routeName) {
    navigatorKey.currentState?.pushReplacementNamed(routeName);
  }

  static void navigateToPage(String routeName) {
    navigatorKey.currentState?.pushNamed(routeName);
  }

  static navigateBack() {
    navigatorKey.currentState?.pop();
  }
}
