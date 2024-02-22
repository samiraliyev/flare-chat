import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flare_chat_app/Models/Failure/chat_failure_model.dart';
import 'package:flare_chat_app/Models/Response/user_info_model.dart';
import 'package:multiple_result/multiple_result.dart';

import '../Contractors/home_repository.dart';
import '../DI/injection.dart';
import '../Services/Local/shared_preferences_service.dart';
import '../Utility/Firebase/firebase_collections.dart';

class ImpleHomeRespositoy extends IHomeRespositoy {
  final _firebaseMessageCollection = FirebaseCollection.messages.reference;
  final _firebaseUserCollection = FirebaseCollection.users.reference;
  final _prefs = getIt.get<SharedPreferencesService>();

  @override
  Result<Stream<QuerySnapshot<Object?>>, ChatFailureModel> fetcAllMessage() {
    try {
      final response = _firebaseMessageCollection.snapshots();
      return Success(response);
    } catch (e) {
      return Error(ChatFailureModel());
    }
  }

  @override
  Future<Result<DocumentSnapshot<UserInfoModel>, ChatFailureModel>> fetchUserInfomation() async {
    try {
      final userId = await _prefs.getString('userId');
      print(userId);
      final response = await _firebaseUserCollection.doc(userId).withConverter(
        fromFirestore: (snapshot, option) {
          return UserInfoModel.fromJson(snapshot.data()!);
        },
        toFirestore: (value, options) {
          return value.toJson();
        },
      ).get();
      return Success(response);
    } catch (e) {
      return Error(ChatFailureModel());
    }
  }

  @override
  Future<void> sendMessage(String text, String username) async {
    try {
      await _firebaseMessageCollection.add({'text': text, 'username': username});
    } catch (e) {}
  }
}
