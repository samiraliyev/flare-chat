import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_chat_app/Services/Local/shared_preferences_service.dart';
import 'package:flare_chat_app/Utility/Extension/svg_image_extension.dart';
import 'package:multiple_result/multiple_result.dart';

import '../Contractors/auth_repository.dart';
import '../DI/injection.dart';
import '../Models/Failure/auth_failure_model.dart';
import '../Services/Firebase/auth_services.dart';
import '../Utility/Firebase/firebase_collections.dart';

class ImpleAuthRepository extends IAuthRepository {
  final _authDataSource = getIt.get<AuthServices>();
  final _prefs = getIt.get<SharedPreferencesService>();

  final collection = FirebaseCollection.users.reference;

  @override
  Future<Result<User, AuthFailureModel>> signUpWithEmail(
      {required String email,
      required String password,
      required String repassword,
      required String username,
      required String phone,
      required String image}) async {
    try {
      if (password == repassword) {
        final result = await _authDataSource.signUpWithEmail(email: email, password: password);
        if (result != null) {
          await _prefs.setBool('logged', true);
          await _prefs.setString('userId', result.uid);
          await collection.doc(result.uid).set({
            'username': username,
            'password': password,
            'phone': phone,
            'email': result.email,
            'userId': result.uid,
            'image': image,
          });
          return Success(result);
        }
      }
      return Error(AuthFailureModel(message: 'Password Confirm!', image: SvgImagePath.fillinput.toPath()));
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'network-request-failed') {
        return Error(AuthFailureModel(message: 'No Internet Connection', image: SvgImagePath.networkerror.toPath()));
      } else if (e.code == "email-already-in-use") {
        return Error(AuthFailureModel(message: 'Already user is valid', image: SvgImagePath.samemail.toPath()));
      } else if (e.code == 'invalid-email') {
        return Error(AuthFailureModel(message: 'Please write an email', image: SvgImagePath.emailerror.toPath()));
      } else if (e.code == 'channel-error') {
        return Error(AuthFailureModel(message: 'Fill in the blanks', image: SvgImagePath.fillinput.toPath()));
      } else {
        return Error(
            AuthFailureModel(message: 'Email and password field are required', image: SvgImagePath.usernot.toPath()));
      }
    }
  }

  @override
  Future<Result<User, AuthFailureModel>> signInEmail(String email, String password) async {
    try {
      final result = await _authDataSource.signInWithEmail(email: email, password: password);
      if (result != null) {
        await _prefs.setBool('logged', true);
        await _prefs.setString('userId', result.uid);
        return Success(result);
      }
      return Error(AuthFailureModel(message: 'Password Confirm!', image: SvgImagePath.fillinput.toPath()));
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'network-request-failed') {
        return Error(AuthFailureModel(message: 'No Internet Connection', image: SvgImagePath.networkerror.toPath()));
      } else if (e.code == "INVALID_LOGIN_CREDENTIALS") {
        return Error(AuthFailureModel(message: 'User not found', image: SvgImagePath.usernot.toPath()));
      } else if (e.code == 'invalid-email') {
        return Error(AuthFailureModel(message: 'Please write an email', image: SvgImagePath.emailerror.toPath()));
      } else if (e.code == 'channel-error') {
        return Error(AuthFailureModel(message: 'Fill in the blanks', image: SvgImagePath.fillinput.toPath()));
      } else {
        return Error(
            AuthFailureModel(message: 'Email and password field are required', image: SvgImagePath.usernot.toPath()));
      }
    }
  }

  @override
  Future<Result<User, AuthFailureModel>> signInWithGoogle() async {
    try {
      final result = await _authDataSource.signInWithGoogle();
      await _prefs.setBool('logged', true);
      if (result != null) {
        await _prefs.setBool('logged', true);
        await _prefs.setString('userId', result.uid);
        await collection.doc(result.uid).set({
          'username': result.displayName,
          'password': result.displayName,
          'email': result.email,
          'userId': result.uid,
          'image': result.photoURL,
          'phone': result.phoneNumber,
        });
        return Success(result);
      }
      return Error(AuthFailureModel(message: 'Password Confirm!', image: SvgImagePath.fillinput.toPath()));
    } catch (e) {
      return Error(AuthFailureModel(message: 'sdfsdf', image: ''));
    }
  }

  @override
  Future<Result<bool, AuthFailureModel>?> checkAuth() async {
    try {
      final isAuth = await _prefs.getBool('logged');
      return Success(isAuth ?? false);
    } catch (e) {
      return Error(AuthFailureModel(
        image: '',
        message: 'sdfsdfsd',
      ));
    }
  }
}
