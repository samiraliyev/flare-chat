import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flare_chat_app/DI/injection.dart';
import 'package:flare_chat_app/Repositories/imple_auth_repository.dart';
import 'package:flare_chat_app/Utility/Picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';

import '../../Utility/Firebase/firebase_storage.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  final _authRepository = getIt.get<ImpleAuthRepository>();
  final _firebaseStorage = getIt.get<FirebaseStorageReference>();
  Uint8List? _selectedFileBytes;
  XFile? _selectedFile;
  Uint8List? get selectedFileBytes => _selectedFileBytes;

  Future<void> pickAndCheckImage() async {
    _selectedFile = await PickImage().pickImageFromGallery();
    _selectedFileBytes = await _selectedFile?.readAsBytes();
  }

  Future<String> sendImageToStorage() async {
    final imageRef = _firebaseStorage.createImageReference(_selectedFile);
    if (imageRef == null) throw Exception('image is empty');
    if (_selectedFileBytes == null) return '';
    await imageRef.putData(_selectedFileBytes!, SettableMetadata(contentType: 'image/png'));
    final url = await imageRef.getDownloadURL();
    return url;
  }

  Future<void> signUpWithEmail(
      {required String email,
      required String password,
      required String repassword,
      required String phone,
      required String username}) async {
    emit(SignUpProgress());
    final getImage = await sendImageToStorage();
    if (getImage.isEmpty) return;
    final result = await _authRepository.signUpWithEmail(
        email: email, password: password, phone: phone, username: username, image: getImage, repassword: repassword);
        

    if (result.isSuccess()) {
      emit(SignUpSuccess());
    } else if (result.isError()) {
      final errorResult = result.tryGetError();
      emit(SignUpFailure(message: errorResult!.message, image: errorResult.image));
    }
  }
}
