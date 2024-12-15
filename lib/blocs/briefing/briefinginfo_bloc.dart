
import 'package:equatable/equatable.dart';
import 'package:esalesapp/models/briefing/briefinglist_model.dart';
import 'package:esalesapp/repositories/briefing/briefinglist_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'briefinginfo_event.dart';
part 'briefinginfo_state.dart';

class BriefingInfoBloc extends Bloc<BriefingInfoEvents, BriefingInfoState> {
  BriefingInfoBloc() : super(const BriefingInfoState()) {
    on<SetSelectedItemBriefingInfoEvent>(onSetSelectedItemBriefingList);
    on<CekStatusBriefingHariIniEvent>(onCekStatusBriefingHariIni);
  }

  Future<void> onSetSelectedItemBriefingList(
      SetSelectedItemBriefingInfoEvent event,
      Emitter<BriefingInfoState> emit) async {
    //debugPrint("event.selectedItem : ${jsonEncode(event.selectedItem)}");

    emit(state.copyWith(selectedItem: event.selectedItem));

    //debugPrint("state.selectedItem : ${jsonEncode(state.selectedItem)}");
  }

  Future<void> onCekStatusBriefingHariIni(CekStatusBriefingHariIniEvent event,
      Emitter<BriefingInfoState> emit) async {
    BriefinglistRepository repo = BriefinglistRepository();
    bool hasPassed = await repo.checkHasPassedTodaysBriefing();
    //debugPrint("onCekStatusBriefingHariIni hasPassed : $hasPassed");
    emit(state.copyWith(hasPassedBriefing: hasPassed));
  }
}
