import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multiple_result/multiple_result.dart';

import '../Models/Failure/chat_failure_model.dart';
import '../Models/Response/user_info_model.dart';

abstract class IHomeRespositoy {
  Result<Stream<QuerySnapshot<Object?>>, ChatFailureModel> fetcAllMessage();
  Future<Result<DocumentSnapshot<UserInfoModel>, ChatFailureModel>> fetchUserInfomation();
  Future<void> sendMessage(String text, String username);
}
