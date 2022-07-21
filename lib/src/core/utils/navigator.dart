
import 'package:flutter/material.dart';
import 'package:routinechecker/main.dart';

void navigateReplace(BuildContext context, String route,
        {bool isDialog = false}) =>
    Navigator.pushReplacementNamed(context, route);

void navigateTo(BuildContext context, Widget route, {bool isDialog = false}) =>
    Navigator.push(
        context,
        PageRouteBuilder(pageBuilder: (context, animation, secondaryAnim) {
          return route;
        }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
                .animate(animation),
            child: child,
          );
        }));

void navigateReplaceTo(BuildContext context, Widget route,
        {bool isDialog = false}) =>
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(pageBuilder: (context, animation, secondaryAnim) {
          return route;
        }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
                .animate(animation),
            child: child,
          );
        }));

void navigate(Widget route, {bool isDialog = false}) =>
    navigatorKey.currentState!.push(
        PageRouteBuilder(pageBuilder: (context, animation, secondaryAnim) {
      return route;
    }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
            .animate(animation),
        child: child,
      );
    }));

void pushUntil(BuildContext context, Widget route) {
  Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(pageBuilder: (context, animation, secondaryAnim) {
        return route;
      }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
              .animate(animation),
          child: child,
        );
      }),
      (Route<dynamic> route) => false);
}

void popToFirst(BuildContext context) =>
    Navigator.of(context).popUntil((Route<dynamic> route) => route.isFirst);

void popView(BuildContext context) => Navigator.pop(context);

// dynamic navigateTransparentRoute(BuildContext context, Widget route) {
//   return Navigator.push(
//     context,
//     TransparentRoute(
//       builder: (BuildContext context) => route,
//     ),
//   );
// }

