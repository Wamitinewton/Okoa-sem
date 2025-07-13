import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:okoa_sem/core/config/app_colors.dart';
import 'package:okoa_sem/core/config/app_theme.dart';
import 'package:okoa_sem/di/injection_container.dart';
import 'package:okoa_sem/features/auth/presentation/widgets/auth_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

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
    return MaterialApp(
      title: 'Okoa Sem - Your Academic Success Partner',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.responsiveTheme(context),
      home: const AuthWrapper(),
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