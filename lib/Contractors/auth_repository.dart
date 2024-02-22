import 'package:firebase_auth/firebase_auth.dart';
import 'package:multiple_result/multiple_result.dart';

import '../Models/Failure/auth_failure_model.dart';

abstract class IAuthRepository {
  Future<Result<User, AuthFailureModel>> signInEmail(String email, String password);
  Future<Result<User, AuthFailureModel>> signUpWithEmail(
      {required String email,
      required String password,
      required String repassword,

      required String username,
      required String phone,
      required String image});

  Future<Result<User, AuthFailureModel>> signInWithGoogle();
  Future<Result<bool, AuthFailureModel>?> checkAuth();
}
