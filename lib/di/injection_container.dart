import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:okoa_sem/features/authentication/di/auth_injection_container.dart';
import 'package:okoa_sem/features/otp/data/repository/otp_repository_impl.dart';
import 'package:okoa_sem/features/otp/domain/repositories/otp_repository.dart';
import 'package:okoa_sem/features/otp/domain/user_cases/resend_otp_use_case.dart' as otp;
import 'package:okoa_sem/features/otp/domain/user_cases/send_otp_use_case.dart';
import 'package:okoa_sem/features/otp/domain/user_cases/verifiy_otp_use_case.dart';
import 'package:okoa_sem/features/otp/presentation/bloc/otp_bloc.dart';

final GetIt getIt = GetIt.instance;

void configureDependencies() {
  _configureSupabase();
  _configureAuthFeature();
  _configureOtpFeature();
}

void _configureSupabase() {
  getIt.registerLazySingleton<SupabaseClient>(
    () => Supabase.instance.client,
  );
  
  authGetIt.registerLazySingleton<SupabaseClient>(
    () => Supabase.instance.client,
  );
}

void _configureAuthFeature() {
  configureAuthDependencies();
}

void _configureOtpFeature() {
  getIt.registerLazySingleton<OtpRepository>(
    () => OtpRepositoryImpl(),
  );

  getIt.registerLazySingleton<SendOtpUseCase>(
    () => SendOtpUseCase(getIt<OtpRepository>()),
  );

  getIt.registerLazySingleton<VerifyOtpUseCase>(
    () => VerifyOtpUseCase(getIt<OtpRepository>()),
  );

  getIt.registerLazySingleton<otp.ResendOtpUseCase>(
    () => otp.ResendOtpUseCase(getIt<OtpRepository>()),
  );

  getIt.registerFactory<OtpBloc>(
    () => OtpBloc(
      sendOtpUseCase: getIt<SendOtpUseCase>(),
      verifyOtpUseCase: getIt<VerifyOtpUseCase>(),
      resendOtpUseCase: getIt<otp.ResendOtpUseCase>(),
    ),
  );
}