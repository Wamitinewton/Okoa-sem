import 'package:get_it/get_it.dart';
import 'package:okoa_sem/features/authentication/domain/usecases/verifiy_phone_use_case.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:okoa_sem/features/authentication/data/datasources/auth_data_source.dart';
import 'package:okoa_sem/features/authentication/data/datasources/supabase_auth_data_source.dart';
import 'package:okoa_sem/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:okoa_sem/features/authentication/domain/repositories/auth_repository.dart';
import 'package:okoa_sem/features/authentication/domain/usecases/sign_up_use_case.dart';
import 'package:okoa_sem/features/authentication/domain/usecases/sign_in_with_phone_use_case.dart';
import 'package:okoa_sem/features/authentication/domain/usecases/sign_in_with_password_use_case.dart';
import 'package:okoa_sem/features/authentication/domain/usecases/resend_otp_use_case.dart';
import 'package:okoa_sem/features/authentication/domain/usecases/sign_out_use_case.dart';
import 'package:okoa_sem/features/authentication/domain/usecases/get_current_session_use_case.dart';
import 'package:okoa_sem/features/authentication/domain/usecases/refresh_session_use_case.dart';
import 'package:okoa_sem/features/authentication/domain/usecases/update_profile_use_case.dart';
import 'package:okoa_sem/features/authentication/domain/usecases/check_username_availability_use_case.dart';
import 'package:okoa_sem/features/authentication/presentation/bloc/auth_bloc.dart';
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
  // Register Supabase client
  // Note: This should be initialized in main.dart before calling configureDependencies
  getIt.registerLazySingleton<SupabaseClient>(
    () => Supabase.instance.client,
  );
}

void _configureAuthFeature() {
  // Data sources
  getIt.registerLazySingleton<AuthDataSource>(
    () => SupabaseAuthDataSource(getIt<SupabaseClient>()),
  );

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthDataSource>()),
  );

  // Use cases
  getIt.registerLazySingleton<SignUpUseCase>(
    () => SignUpUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<VerifyPhoneUseCase>(
    () => VerifyPhoneUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<SignInWithPhoneUseCase>(
    () => SignInWithPhoneUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<SignInWithPasswordUseCase>(
    () => SignInWithPasswordUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<ResendOtpUseCase>(
    () => ResendOtpUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<SignOutUseCase>(
    () => SignOutUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<GetCurrentSessionUseCase>(
    () => GetCurrentSessionUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<RefreshSessionUseCase>(
    () => RefreshSessionUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<UpdateProfileUseCase>(
    () => UpdateProfileUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<CheckUsernameAvailabilityUseCase>(
    () => CheckUsernameAvailabilityUseCase(getIt<AuthRepository>()),
  );

  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(
      signUpUseCase: getIt<SignUpUseCase>(),
      verifyPhoneUseCase: getIt<VerifyPhoneUseCase>(),
      signInWithPhoneUseCase: getIt<SignInWithPhoneUseCase>(),
      signInWithPasswordUseCase: getIt<SignInWithPasswordUseCase>(),
      resendOtpUseCase: getIt<ResendOtpUseCase>(),
      signOutUseCase: getIt<SignOutUseCase>(),
      getCurrentSessionUseCase: getIt<GetCurrentSessionUseCase>(),
      refreshSessionUseCase: getIt<RefreshSessionUseCase>(),
      updateProfileUseCase: getIt<UpdateProfileUseCase>(),
      checkUsernameAvailabilityUseCase: getIt<CheckUsernameAvailabilityUseCase>(),
    ),
  );
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