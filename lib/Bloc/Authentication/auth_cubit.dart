import 'package:bloc/bloc.dart';
import 'package:flare_chat_app/DI/injection.dart';
import 'package:flare_chat_app/Repositories/imple_auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState.initial);
  final _authRepository = getIt.get<ImpleAuthRepository>();
  Future<void> checkAuth() async {
    final result = await _authRepository.checkAuth();
    await Future.delayed(const Duration(seconds: 4));
    if (result!.isSuccess()) {
      final isAuth = result.tryGetSuccess();
      print(isAuth);

      emit(isAuth! ? AuthState.authentication : AuthState.unauthentication);
    } else if (result.isError()) {
      emit(AuthState.unauthentication);
    }
  }
}
