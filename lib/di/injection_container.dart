import 'package:get_it/get_it.dart';
import 'package:okoa_sem/features/authentication/presentation/bloc/auth_bloc.dart';

final GetIt getIt = GetIt.instance;

void configureDependencies() {

  getIt.registerFactory<AuthBloc>(() => AuthBloc());
}