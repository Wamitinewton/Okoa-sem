import 'package:get_it/get_it.dart';
import 'package:okoa_sem/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:okoa_sem/features/otp/data/repository/otp_repository_impl.dart';
import 'package:okoa_sem/features/otp/domain/repositories/otp_repository.dart';
import 'package:okoa_sem/features/otp/domain/user_cases/resend_otp_use_case.dart';
import 'package:okoa_sem/features/otp/domain/user_cases/send_otp_use_case.dart';
import 'package:okoa_sem/features/otp/domain/user_cases/verifiy_otp_use_case.dart';
import 'package:okoa_sem/features/otp/presentation/bloc/otp_bloc.dart';

final GetIt getIt = GetIt.instance;

void configureDependencies() {

  getIt.registerFactory<AuthBloc>(() => AuthBloc());

  _configureOtpFeature();
}

void _configureOtpFeature() {

  getIt.registerLazySingleton<OtpRepository>(
    () => OtpRepositoryImpl()
  );

  getIt.registerLazySingleton<SendOtpUseCase>(
    () => SendOtpUseCase(getIt<OtpRepository>()),
  );

  getIt.registerLazySingleton<VerifyOtpUseCase>(
    () => VerifyOtpUseCase(getIt<OtpRepository>()),
  );

  getIt.registerLazySingleton<ResendOtpUseCase>(
    () => ResendOtpUseCase(getIt<OtpRepository>()),
  );

  getIt.registerFactory<OtpBloc>(
    () => OtpBloc(
      sendOtpUseCase: getIt<SendOtpUseCase>(),
      verifyOtpUseCase: getIt<VerifyOtpUseCase>(),
      resendOtpUseCase: getIt<ResendOtpUseCase>(),
    )
  );
}