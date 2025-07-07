import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/network/connection_checkker.dart';
import 'package:blog_app/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositroyImpl implements Authrepository {
  final AuthRemoteDatasource remoteDatasource;
  final ConnectionCheckker connectionCheckker;
  AuthRepositroyImpl(this.remoteDatasource, this.connectionCheckker);

  @override
  Future<Either<Failure, User>> signUpWithEmailPasswoerd({
    required String name,
    required String email,
    required String password,
  }) {
    return _getUser(
      () async => await remoteDatasource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, User>> signInWithEmailPasswoerd({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDatasource.signInWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<Failure, User>> _getUser(Future<User> Function() fn) async {
    try {
      if (!await (connectionCheckker.isConnected())) {
        return left(Failure('No Internet Connection'));
      }
      final user = await fn();
      return right(user);
    } on sb.AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerExceptoion catch (e) {
      return left(Failure(e.excetionMessage));
    }
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      if (!await (connectionCheckker.isConnected())) {
        final session = remoteDatasource.currentUserSesssion;
        if(session==null){
          return left(Failure('User not logged in'));
        }
         return right(UserModel(id: session.user.id, email: session.user.email?? '', name: ''));
      }
      final user = await remoteDatasource.getCurrentUserData();
      if (user == null) {
        return left(Failure('User not logged in'));
      }
      return right(user);
    } on ServerExceptoion catch (e) {
      return left(Failure(e.excetionMessage));
    }
  }
}
