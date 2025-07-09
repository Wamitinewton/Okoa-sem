import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  splash('/'),
  onboarding('/onboarding'),
  login('/login'),
  signup('/signup'),
  home('/home');

  const AppRoute(this.path);

  final String path;
}

extension AppRouteNavigation on AppRoute{
  void go(BuildContext context) => context.go(path);

  void push(BuildContext context) => context.push(path);

  void pushReplacement(BuildContext context) => context.pushReplacement(path);
}