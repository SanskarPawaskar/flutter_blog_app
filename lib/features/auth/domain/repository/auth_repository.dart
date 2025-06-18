import 'package:blog_app/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class Authrepository {
  Future<Either<Failure, String>> signUpWithEmailPasswoerd({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, String>> signInWithEmailPasswoerd({
    required String email,
    required String password,
  });
}
