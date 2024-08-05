import 'package:equatable/equatable.dart';
import 'package:esalesapp/models/onboardmenu/onboardmenucari_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/repositories/onboardmenu/onboardmenucari_repository.dart';

import '../../common/constants.dart';

part 'onboardmenucari_event.dart';
part 'onboardmenucari_state.dart';

class OnBoardMenuCariBloc
    extends Bloc<OnBoardMenuCariEvents, OnBoardMenuCariState> {
  OnBoardMenuCariBloc() : super(const OnBoardMenuCariState()) {
    on<LoadOnBoardMenuCariEvent>(onLoadMenu);
  }

  Future<void> onLoadMenu(LoadOnBoardMenuCariEvent event,
      Emitter<OnBoardMenuCariState> emit) async {

    debugPrint("onLoadMenu #10");

    OnBoardMenuCariRepository repo = OnBoardMenuCariRepository();
    OnBoardMenuCariModel item = await repo.getOnBoardMenuCari();
    
    debugPrint("onLoadMenu item : ${item.toJson()}");

    emit(state.copyWith(item: item, status: ListStatus.success));
  }
}
