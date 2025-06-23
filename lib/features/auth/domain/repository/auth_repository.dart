import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class Authrepository {
  Future<Either<Failure, User>> signUpWithEmailPasswoerd({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> signInWithEmailPasswoerd({
    required String email,
    required String password,
  });
}
