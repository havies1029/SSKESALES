import 'package:equatable/equatable.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/list_extension.dart';
import 'package:esalesapp/models/jobreal/jobrealcari_model.dart';
import 'package:esalesapp/repositories/jobreal/jobrealcari_repository.dart';

part 'jobrealcari_event.dart';
part 'jobrealcari_state.dart';

class JobRealCariBloc extends Bloc<JobRealCariEvents, JobRealCariState> {
  JobRealCariBloc() : super(const JobRealCariState()) {
    on<FetchJobRealCariEvent>(onFetchJobRealCari);
    on<RefreshJobRealCariEvent>(onRefreshJobRealCari);
    on<UbahJobRealCariEvent>(onUbahJobRealCari);
    on<TambahJobRealCariEvent>(onTambahJobRealCari);
    on<CloseDialogJobRealCariEvent>(onCloseDialogJobRealCari);
    on<ResetStateJobRealCariEvent>(onResetState);
    on<SetFilterDocRealCariEvent>(onSetFilterDoc);
    on<LihatJobRealCariEvent>(onLihatJobRealCari);
    on<JobRealDuplicateEvent>(onDuplicateJobReal);
    on<JobRealMove2NextFlowEvent>(onMove2NextFlow);
  }

  JobRealCariRepository repo = JobRealCariRepository();

  Future<void> onResetState(
      ResetStateJobRealCariEvent event, Emitter<JobRealCariState> emit) async {
    emit(state.copyWith(
        status: ListStatus.initial,
        items: <JobRealCariModel>[],
        hasReachedMax: false,
        hal: 0,
        viewMode: "",
        recordId: "",
        filterDoc: "all",
        personId: event.personId));
  }

  Future<void> onSetFilterDoc(
      SetFilterDocRealCariEvent event, Emitter<JobRealCariState> emit) async {
    emit(state.copyWith(requestToRefresh: false));
    emit(state.copyWith(filterDoc: event.filterDoc, requestToRefresh: true));
  }

  Future<void> onRefreshJobRealCari(
      RefreshJobRealCariEvent event, Emitter<JobRealCariState> emit) async {
    emit(const JobRealCariState());
    emit(state.copyWith(personId: event.personId));
    //await Future.delayed(const Duration(seconds: 1));

    add(FetchJobRealCariEvent(
        hal: 0,
        searchText: event.searchText,
        filterDoc: event.filterDoc,
        jobCatGroupId: event.jobCatGroupId));
  }

  Future<void> onFetchJobRealCari(
      FetchJobRealCariEvent event, Emitter<JobRealCariState> emit) async {
    if (state.hasReachedMax) return;

    if (state.status == ListStatus.initial) {
      List<JobRealCariModel> items = await repo.getJobRealCari(state.personId,
          event.jobCatGroupId, event.filterDoc, event.searchText, 0);
      return emit(state.copyWith(
          items: items,
          hasReachedMax: false,
          status: ListStatus.success,
          hal: 1));
    }
    List<JobRealCariModel> items = await repo.getJobRealCari(state.personId,
        event.jobCatGroupId, event.filterDoc, event.searchText, state.hal);
    if (items.isEmpty) {
      return emit(state.copyWith(hasReachedMax: true));
    } else {
      List<JobRealCariModel> jobRealCari = List.of(state.items)..addAll(items);

      final result = jobRealCari
          .whereWithIndex((e, index) =>
              jobRealCari.indexWhere((e2) => e2.jobreal1Id == e.jobreal1Id) ==
              index)
          .toList();

      return emit(state.copyWith(
          items: result,
          hasReachedMax: false,
          status: ListStatus.success,
          hal: state.hal + 1));
    }
  }

  Future<void> onCloseDialogJobRealCari(
      CloseDialogJobRealCariEvent event, Emitter<JobRealCariState> emit) async {
    return emit(state.copyWith(viewMode: ""));
  }

  Future<void> onTambahJobRealCari(
      TambahJobRealCariEvent event, Emitter<JobRealCariState> emit) async {
    return emit(state.copyWith(viewMode: "tambah"));
  }

  Future<void> onUbahJobRealCari(
      UbahJobRealCariEvent event, Emitter<JobRealCariState> emit) async {
    return emit(state.copyWith(viewMode: "ubah", recordId: event.recordId));
  }

  Future<void> onLihatJobRealCari(
      LihatJobRealCariEvent event, Emitter<JobRealCariState> emit) async {
    return emit(state.copyWith(viewMode: "lihat", recordId: event.recordId));
  }

  Future<void> onDuplicateJobReal(
      JobRealDuplicateEvent event, Emitter<JobRealCariState> emit) async {
    emit(state.copyWith(
        isDuplicating: true,
        isDuplicated: false,
        hasFailure: false,
        requestToRefresh: false));
    ReturnDataAPI result = await repo.jobRealDuplicate(event.recordId);
    emit(state.copyWith(
        isDuplicating: false,
        isDuplicated: true,
        hasFailure: result.success,
        requestToRefresh: true));
  }

  Future<void> onMove2NextFlow(
      JobRealMove2NextFlowEvent event, Emitter<JobRealCariState> emit) async {
    emit(state.copyWith(
        isMovingNextFlow: true,
        isMovedNextFlow: false,
        hasFailure: false,
        requestToRefresh: false));
    ReturnDataAPI result = await repo.jobRealMove2NextFlow(event.recordId);
    emit(state.copyWith(
        isMovingNextFlow: false,
        isMovedNextFlow: true,
        hasFailure: result.success,
        requestToRefresh: true));
  }
}
