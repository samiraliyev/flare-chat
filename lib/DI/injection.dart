import 'package:flare_chat_app/Bloc/SignIn/sign_in_cubit.dart';
import 'package:flare_chat_app/Utility/Firebase/firebase_storage.dart';
import 'package:get_it/get_it.dart';

import '../Repositories/imple_auth_repository.dart';
import '../Services/Firebase/auth_services.dart';
import '../Services/Local/shared_preferences_service.dart';

final getIt = GetIt.instance;
void setup() {
  getIt.registerLazySingleton(() => SharedPreferencesService());
  getIt.registerLazySingleton(() => AuthServices());
  getIt.registerLazySingleton(() => ImpleAuthRepository());
  getIt.registerLazySingleton(() => SignInCubit());
  getIt.registerLazySingleton(() => FirebaseStorageReference());


}
