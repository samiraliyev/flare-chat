import 'package:bloc/bloc.dart';
import 'package:flare_chat_app/DI/injection.dart';
import 'package:flare_chat_app/Repositories/imple_auth_repository.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());
  final _authRepository = getIt.get<ImpleAuthRepository>();

  Future<void> signInWithEmail({required String email, required String password}) async {
    emit(SignInProgress());
    final result = await _authRepository.signInEmail(email, password);
    await Future.delayed(const Duration(seconds: 2));
    if (result.isSuccess()) {
      emit(SignInSuccess());
    } else if (result.isError()) {
      final errorResult = result.tryGetError();
      emit(SignInFailure(message: errorResult!.message, image: errorResult.image));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(SignInProgress());
    final result = await _authRepository.signInWithGoogle();
    if (result.isSuccess()) {
      emit(SignInSuccess());
    } else if (result.isError()) {
      final errorResult = result.tryGetError();
      emit(SignInFailure(
        message: errorResult!.message,
      ));
    }
  }
}
