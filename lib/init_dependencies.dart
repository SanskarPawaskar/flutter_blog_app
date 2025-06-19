import 'package:blog_app/core/private/app_private.dart';
import 'package:blog_app/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:blog_app/features/auth/data/repositories/auth_repositroy_impl.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app/features/auth/presestation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;


Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: AppPrivate.supabaseUrl,
    anonKey: AppPrivate.supabaseAnonKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(serviceLocator()),
  );

  serviceLocator.registerFactory<Authrepository>(
    () => AuthRepositroyImpl(serviceLocator()),
  );

  serviceLocator.registerFactory(() => UserSignUp(serviceLocator()));

  serviceLocator.registerLazySingleton(
    () => AuthBloc(userSignUp: serviceLocator()),
  );
}
