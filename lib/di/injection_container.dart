import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:okoa_sem/features/authentication/di/auth_injection_container.dart';

final GetIt getIt = GetIt.instance;

void configureDependencies() {
  _configureSupabase();
  _configureAuthFeature();
}

void _configureSupabase() {
  if (!getIt.isRegistered<SupabaseClient>()) {
    getIt.registerLazySingleton<SupabaseClient>(
      () => Supabase.instance.client,
    );
  }
}

void _configureAuthFeature() {
  configureAuthDependencies(getIt.get<SupabaseClient>());
}