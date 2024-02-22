import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

final class FirebaseStorageReference {
  Reference? createImageReference(
    XFile? selectFile,
  ) {
    if (selectFile == null || (selectFile.name.isEmpty)) {
      return null;
    }
    final storageRef = FirebaseStorage.instance.ref();
    final imageRef = storageRef.child(selectFile.name);
    return imageRef;
  }
}
