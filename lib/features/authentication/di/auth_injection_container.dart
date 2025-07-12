import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:okoa_sem/features/authentication/data/datasources/auth_data_source.dart';
import 'package:okoa_sem/features/authentication/data/datasources/supabase_auth_data_source.dart';
import 'package:okoa_sem/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:okoa_sem/features/authentication/domain/repositories/auth_repository.dart';
import 'package:okoa_sem/features/authentication/domain/usecases/verifiy_phone_use_case.dart';
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

final GetIt authGetIt = GetIt.instance;

void configureAuthDependencies() {
  authGetIt.registerLazySingleton<AuthDataSource>(
    () => SupabaseAuthDataSource(authGetIt<SupabaseClient>()),
  );

  authGetIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authGetIt<AuthDataSource>()),
  );

  authGetIt.registerLazySingleton<SignUpUseCase>(
    () => SignUpUseCase(authGetIt<AuthRepository>()),
  );

  authGetIt.registerLazySingleton<VerifyPhoneUseCase>(
    () => VerifyPhoneUseCase(authGetIt<AuthRepository>()),
  );

  authGetIt.registerLazySingleton<SignInWithPhoneUseCase>(
    () => SignInWithPhoneUseCase(authGetIt<AuthRepository>()),
  );

  authGetIt.registerLazySingleton<SignInWithPasswordUseCase>(
    () => SignInWithPasswordUseCase(authGetIt<AuthRepository>()),
  );

  authGetIt.registerLazySingleton<ResendOtpUseCase>(
    () => ResendOtpUseCase(authGetIt<AuthRepository>()),
  );

  authGetIt.registerLazySingleton<SignOutUseCase>(
    () => SignOutUseCase(authGetIt<AuthRepository>()),
  );

  authGetIt.registerLazySingleton<GetCurrentSessionUseCase>(
    () => GetCurrentSessionUseCase(authGetIt<AuthRepository>()),
  );

  authGetIt.registerLazySingleton<RefreshSessionUseCase>(
    () => RefreshSessionUseCase(authGetIt<AuthRepository>()),
  );

  authGetIt.registerLazySingleton<UpdateProfileUseCase>(
    () => UpdateProfileUseCase(authGetIt<AuthRepository>()),
  );

  authGetIt.registerLazySingleton<CheckUsernameAvailabilityUseCase>(
    () => CheckUsernameAvailabilityUseCase(authGetIt<AuthRepository>()),
  );

  authGetIt.registerFactory<AuthBloc>(
    () => AuthBloc(
      signUpUseCase: authGetIt<SignUpUseCase>(),
      verifyPhoneUseCase: authGetIt<VerifyPhoneUseCase>(),
      signInWithPhoneUseCase: authGetIt<SignInWithPhoneUseCase>(),
      signInWithPasswordUseCase: authGetIt<SignInWithPasswordUseCase>(),
      resendOtpUseCase: authGetIt<ResendOtpUseCase>(),
      signOutUseCase: authGetIt<SignOutUseCase>(),
      getCurrentSessionUseCase: authGetIt<GetCurrentSessionUseCase>(),
      refreshSessionUseCase: authGetIt<RefreshSessionUseCase>(),
      updateProfileUseCase: authGetIt<UpdateProfileUseCase>(),
      checkUsernameAvailabilityUseCase: authGetIt<CheckUsernameAvailabilityUseCase>(),
    ),
  );
}