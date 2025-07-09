import 'package:go_router/go_router.dart';
import 'package:okoa_sem/core/router/route.dart';
import 'package:okoa_sem/splash.dart';

final GoRouter router = GoRouter(
  initialLocation: AppRoute.splash.path,
  routes: [
    GoRoute(
      path: AppRoute.splash.path,
      name: 'splash',
      builder: (context, state) => const SplashScreen()
      )
]);