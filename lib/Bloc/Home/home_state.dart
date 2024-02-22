import 'package:flare_chat_app/Models/Response/user_info_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeSuccess extends HomeState {
  final UserInfoModel? infoModel;

  HomeSuccess({this.infoModel});
  // final List<MessageModel> items;
  // HomeSuccess({required this.items});
}

class HomeProgress extends HomeState {}

class HomeFailure extends HomeState {
  final String message;
  HomeFailure({required this.message});
}
