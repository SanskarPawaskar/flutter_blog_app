import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';


class UserSignUp implements Usecase<String, UserSignUpParams> {
  final Authrepository authrepository;
  UserSignUp(this.authrepository);

  @override
  Future<Either<Failure, String>> call(UserSignUpParams params) async {
    return await authrepository.signUpWithEmailPasswoerd(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;

  UserSignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
