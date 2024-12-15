
import 'package:equatable/equatable.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/models/combobox/combojobcatgroup_model.dart';
import 'package:esalesapp/repositories/combobox/combojobcatgroup_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/list_extension.dart';
import 'package:esalesapp/models/briefing/briefinglist_model.dart';
import 'package:esalesapp/repositories/briefing/briefinglist_repository.dart';

part 'briefinglist_event.dart';
part 'briefinglist_state.dart';

class BriefinglistBloc extends Bloc<BriefinglistEvents, BriefinglistState> {
  BriefinglistBloc() : super(const BriefinglistState()) {
    on<FetchBriefinglistEvent>(onFetchBriefinglist);
    on<RefreshBriefinglistEvent>(onRefreshBriefinglist);
    on<GetJobCatGroupOtherRecordEvent>(onGetJobCatGroupOtherRecord);
  }

  Future<void> onRefreshBriefinglist(
      RefreshBriefinglistEvent event, Emitter<BriefinglistState> emit) async {
    //debugPrint("onRefreshBriefinglist");

    emit(const BriefinglistState());
    add(FetchBriefinglistEvent());
  }

  Future<void> onFetchBriefinglist(
      FetchBriefinglistEvent event, Emitter<BriefinglistState> emit) async {
    if (state.hasReachedMax) return;

    BriefinglistRepository repo = BriefinglistRepository();
    if (state.status == ListStatus.initial) {
      //debugPrint("onFetchBriefinglist #20");
      List<BriefinglistModel> items = await repo.getBriefinglist();
      //debugPrint("onFetchBriefinglist #30");
      emit(state.copyWith(
        items: items,
        hasReachedMax: false,
        status: ListStatus.success,
      ));

      //debugPrint("onFetchBriefinglist #40");
    }
    List<BriefinglistModel> items = await repo.getBriefinglist();
    if (items.isEmpty) {
      return emit(state.copyWith(hasReachedMax: true));
    } else {
      List<BriefinglistModel> briefinglist = List.of(state.items)
        ..addAll(items);

      final result = briefinglist
          .whereWithIndex((e, index) =>
              briefinglist.indexWhere((e2) => e2.jobId == e.jobId) == index)
          .toList();

      return emit(state.copyWith(
        items: result,
        hasReachedMax: false,
        status: ListStatus.success,
      ));
    }
  }

  Future<void> onGetJobCatGroupOtherRecord(GetJobCatGroupOtherRecordEvent event,
      Emitter<BriefinglistState> emit) async {
    emit(state.copyWith(status: ListStatus.initial));

    ComboJobcatgroupRepository repo = ComboJobcatgroupRepository();
    ComboJobcatgroupModel jobCatGroupOther =
        await repo.getComboJobcatgroupOtherAPI();

    emit(state.copyWith(
        status: ListStatus.success, jobCatGroupOtherRecord: jobCatGroupOther));
  }
}
