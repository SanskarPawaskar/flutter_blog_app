import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';


class AuthRepositroyImpl implements Authrepository {
  AuthRemoteDatasource remoteDatasource;
  AuthRepositroyImpl(this.remoteDatasource);
 

  @override
  Future<Either<Failure, String>> signUpWithEmailPasswoerd({
    required String name,
    required String email,
    required String password,
  }) async {
   try{
   final userId = await  remoteDatasource.signUpWithEmailPassword(name: name, email: email, password: password);
   return right(userId);
   }
   on ServerExceptoion catch(e){
    return left(Failure(e.excetionMessage));
   }
  }
  
  @override
  Future<Either<Failure, String>> signInWithEmailPasswoerd({required String email, required String password}) {
    // TODO: implement signInWithEmailPasswoerd
    throw UnimplementedError();
  }
}
