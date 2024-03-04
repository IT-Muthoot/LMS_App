import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

int backBtTap = 0;

class NavigatorController {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static pagePush(BuildContext context, Widget page) {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => page));
  }

  static pagePushLikePop(BuildContext context, Widget page) {
    return Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(seconds: 1),
        reverseTransitionDuration: const Duration(seconds: 1),
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final tween = Tween(begin: 0.0, end: 1.0);
          final fadeAnimation = animation.drive(tween);
          return FadeTransition(
            opacity: fadeAnimation,
            child: child,
          );
        },
      ),
    );
  }

  static Future<bool> disableBackBt() {
    return Future.value(false);
  }

  static Future<bool> closeApp(int count) {
    backBtTap = backBtTap + count;
    if (backBtTap == 2) {
      if (Platform.isAndroid) {
        SystemNavigator.pop();
        backBtTap = 0;
        return Future.value(false);
      } else {
        exit(0);
        backBtTap = 0;
        return Future.value(true);
      }
    } else {
      Fluttertoast.showToast(msg: "Press again to close");
      return Future.value(false);
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigatorController.navigatorKey, // set property
    );
  }
}
