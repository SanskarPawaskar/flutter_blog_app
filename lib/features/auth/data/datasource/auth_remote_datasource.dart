import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDatasource {
  Session? get currentUserSesssion;
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> signInWithEmailPassword({
    required String email,
    required String password,
  });
  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final SupabaseClient supabaseClient;
  AuthRemoteDatasourceImpl(this.supabaseClient);

  @override
  // TODO: implement currentSesssion
  Session? get currentUserSesssion => supabaseClient.auth.currentSession;

  @override
  Future<UserModel> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      if (response.user == null) {
        throw ServerExceptoion("User is null");
      }
      return UserModel.fromJson(
        response.user!.toJson(),
      ).copyWith(email: currentUserSesssion!.user.email);
    } catch (e) {
      throw ServerExceptoion(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {'name': name},
      );
      if (response.user == null) {
        throw ServerExceptoion("User is null");
      }
      return UserModel.fromJson(
        response.user!.toJson(),
      ).copyWith(email: currentUserSesssion!.user.email);
    } catch (e) {
      throw ServerExceptoion(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUserSesssion != null) {
        final userData = await supabaseClient
            .from('profiles')
            .select()
            .eq('id', currentUserSesssion!.user.id);
        return UserModel.fromJson(
          userData.first,
        ).copyWith(email: currentUserSesssion!.user.email);
      }
      return null;
    } catch (e) {
      throw ServerExceptoion(e.toString());
    }
  }
}
