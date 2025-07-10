import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  splash('/'),
  onboarding('/onboarding'),
  login('/login'),
  signup('/signup'),
  home('/home'),
  otpVerification('/otp-verification');


  const AppRoute(this.path);

  final String path;
}

extension AppRouteNavigation on AppRoute {
  void go(BuildContext context, {Map<String, String>? queryParameters}) {
    if (queryParameters != null) {
      final uri = Uri(path: path, queryParameters: queryParameters);
      context.go(uri.toString());
    } else {
      context.go(path);
    }
  }

  void push(BuildContext context, {Map<String, String>? queryParameters}) {
    if (queryParameters != null) {
      final uri = Uri(path: path, queryParameters: queryParameters);
      context.push(uri.toString());
    } else {
      context.push(path);
    }
  }

  void pushReplacement(BuildContext context, {Map<String, String>? queryParameters}) {
    if (queryParameters != null) {
      final uri = Uri(path: path, queryParameters: queryParameters);
      context.pushReplacement(uri.toString());
    } else {
      context.pushReplacement(path);
    }
  }
}