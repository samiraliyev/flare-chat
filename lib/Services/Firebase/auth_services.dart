import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final class AuthServices {
  final _firebaseAuth = FirebaseAuth.instance;
  Future<User?> signInWithEmail({required String email, required String password}) async {
    final signUser = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    final result = signUser.user;
    return result;
  }

  Future<User?> signUpWithEmail({required String email, required String password}) async {
    final signUser = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    final result = signUser.user;
    return result;
  }

  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? user = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication auth = await user!.authentication;
    final credential = GoogleAuthProvider.credential(accessToken: auth.accessToken, idToken: auth.idToken);
    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    final result = userCredential.user;
    return result;
  }
}
