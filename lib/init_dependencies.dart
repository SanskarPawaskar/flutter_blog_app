import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/network/connection_checkker.dart';
import 'package:blog_app/core/private/app_private.dart';
import 'package:blog_app/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:blog_app/features/auth/data/repositories/auth_repositroy_impl.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_in.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app/features/auth/presestation/bloc/auth_bloc.dart';
import 'package:blog_app/features/blog/data/datasources/blog_local_datasource.dart';
import 'package:blog_app/features/blog/data/datasources/blog_remote_datasource.dart';
import 'package:blog_app/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repositories.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
    url: AppPrivate.supabaseUrl,
    anonKey: AppPrivate.supabaseAnonKey,
  );

  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
  serviceLocator.registerLazySingleton(() => supabase.client);
  serviceLocator.registerLazySingleton(() => Hive.box(name: 'Blogs'));
  serviceLocator.registerFactory(() => InternetConnection());
}

void _initAuth() {
  //core
  serviceLocator
    ..registerLazySingleton(() => AppUserCubit())
    ..registerFactory<ConnectionCheckker>(
      () => ConnectionCheckkerImpl(internetConnection: serviceLocator()),
    );

  //auth
  serviceLocator
    ..registerFactory<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImpl(serviceLocator()),
    )
    ..registerFactory<Authrepository>(
      () => AuthRepositroyImpl(serviceLocator(), serviceLocator()),
    )
    ..registerFactory(() => UserSignUp(serviceLocator()))
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userSignIn: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    )
    ..registerFactory(() => UserSignIn(serviceLocator()))
    ..registerFactory(() => CurrentUser(serviceLocator()));
}

void _initBlog() {
  serviceLocator
    ..registerFactory<BlogRemoteDatasource>(
      () => BlogRemoteDatasourceImpl(serviceLocator()),
    )
    ..registerFactory<BlogLocalDatasource>(
      () => BlogLocalDatasourceImpl(serviceLocator()),
    )
    ..registerFactory<BlogRepositories>(
      () => BlogRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    )
    ..registerFactory(() => GetAllBlogs(serviceLocator()))
    ..registerFactory<UploadBlog>(() => UploadBlog(serviceLocator()))
    ..registerLazySingleton(
      () =>
          BlogBloc(uploadBlog: serviceLocator(), getAllBlogs: serviceLocator()),
    );
}
