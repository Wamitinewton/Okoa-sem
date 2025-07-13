import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:okoa_sem/core/config/app_colors.dart';
import 'package:okoa_sem/core/config/app_theme.dart';
import 'package:okoa_sem/core/router/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.surfaceDark,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const OkoaSemApp());
}

class OkoaSemApp extends StatelessWidget {
  const OkoaSemApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Okoa Sem - Your Academic Success Partner',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.responsiveTheme(context),
      routerConfig: router,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(
              MediaQuery.of(context).textScaler.scale(1.0).clamp(0.8, 1.3),
            ),
          ),
          child: child!,
        );
      },
    );
  }
}