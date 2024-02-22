import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Repositories/imple_home_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final _homeRepository = ImpleHomeRespositoy();
  final StreamController streamController = StreamController();

  Future<void> fetchMessageItem() async {
    emit(HomeProgress());
    final result = _homeRepository.fetcAllMessage();
    if (result.isSuccess()) {
      final response = result.tryGetSuccess();
      response?.listen((event) {
        streamController.add(event.docs.map((doc) => doc.data()).toList());
      });
      emit(HomeSuccess());
    } else if (result.isError()) {
      emit(HomeFailure(message: 'Error'));
    }
  }

  Future<void> fetchUserInformation() async {
    final result = await _homeRepository.fetchUserInfomation();
    if (result.isSuccess()) {
      final response = result.tryGetSuccess();
      if (response != null) {
        emit(HomeSuccess(infoModel: response.data()));
      }
    } else if (result.isError()) {
      emit(HomeFailure(message: 'Problem'));
    }
  }

  Future<void> sendMessage(String text, String username) async {
    await _homeRepository.sendMessage(text, username);
  }
}
