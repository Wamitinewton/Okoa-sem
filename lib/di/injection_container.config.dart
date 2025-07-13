// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;

import '../features/auth/data/datasources/auth_remote_datasource.dart' as _i130;
import '../features/auth/data/datasources/firebase_auth_datasource.dart'
    as _i921;
import '../features/auth/data/repository/auth_repository_impl.dart' as _i920;
import '../features/auth/domain/repository/auth_repository.dart' as _i267;
import '../features/auth/domain/usecases/get_current_user.dart' as _i318;
import '../features/auth/domain/usecases/register_with_email.dart' as _i356;
import '../features/auth/domain/usecases/send_password_reset.dart' as _i498;
import '../features/auth/domain/usecases/sign_in_with_email.dart' as _i33;
import '../features/auth/domain/usecases/sign_in_with_google.dart' as _i345;
import '../features/auth/domain/usecases/sign_out.dart' as _i472;
import '../features/auth/presentation/bloc/auth_bloc.dart' as _i59;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i130.AuthRemoteDataSource>(
      () => _i921.FirebaseAuthDataSource(
        gh<_i59.FirebaseAuth>(),
        gh<_i116.GoogleSignIn>(),
      ),
    );
    gh.lazySingleton<_i267.AuthRepository>(
      () => _i920.AuthRepositoryImpl(gh<_i130.AuthRemoteDataSource>()),
    );
    gh.factory<_i345.SignInWithGoogle>(
      () => _i345.SignInWithGoogle(gh<_i267.AuthRepository>()),
    );
    gh.factory<_i33.SignInWithEmail>(
      () => _i33.SignInWithEmail(gh<_i267.AuthRepository>()),
    );
    gh.factory<_i356.RegisterWithEmail>(
      () => _i356.RegisterWithEmail(gh<_i267.AuthRepository>()),
    );
    gh.factory<_i472.SignOut>(() => _i472.SignOut(gh<_i267.AuthRepository>()));
    gh.factory<_i318.GetCurrentUser>(
      () => _i318.GetCurrentUser(gh<_i267.AuthRepository>()),
    );
    gh.factory<_i318.GetAuthStateChanges>(
      () => _i318.GetAuthStateChanges(gh<_i267.AuthRepository>()),
    );
    gh.factory<_i498.SendPasswordReset>(
      () => _i498.SendPasswordReset(gh<_i267.AuthRepository>()),
    );
    gh.factory<_i59.AuthBloc>(
      () => _i59.AuthBloc(
        gh<_i318.GetCurrentUser>(),
        gh<_i318.GetAuthStateChanges>(),
        gh<_i345.SignInWithGoogle>(),
      ),
    );
    return this;
  }
}
