import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/list_extension.dart';
import 'package:esalesapp/models/jobreal/jobreal2cari_model.dart';
import 'package:esalesapp/repositories/jobreal/jobreal2cari_repository.dart';

part 'jobreal2list_event.dart';
part 'jobreal2list_state.dart';

class JobReal2ListBloc extends Bloc<JobReal2ListEvents, JobReal2ListState> {
  JobReal2ListBloc() : super(const JobReal2ListState()) {
    on<FetchJobReal2ListEvent>(onFetchJobReal2List);
    on<RefreshJobReal2ListEvent>(onRefreshJobReal2List);
  }

  Future<void> onRefreshJobReal2List(
      RefreshJobReal2ListEvent event, Emitter<JobReal2ListState> emit) async {
    emit(const JobReal2ListState());

    await Future.delayed(const Duration(seconds: 1));

    add(FetchJobReal2ListEvent(jobreal1Id: event.jobreal1Id));
  }

  Future<void> onFetchJobReal2List(
      FetchJobReal2ListEvent event, Emitter<JobReal2ListState> emit) async {
    if (state.hasReachedMax) return;

    JobReal2CariRepository repo = JobReal2CariRepository();
    if (state.status == ListStatus.initial) {
      List<JobReal2CariModel> items = await repo.getJobReal2List(event.jobreal1Id);
      return emit(state.copyWith(
        items: items,
        hasReachedMax: false,
        status: ListStatus.success,
      ));
    }
    List<JobReal2CariModel> items = await repo.getJobReal2List(event.jobreal1Id);
    if (items.isEmpty) {
      return emit(state.copyWith(hasReachedMax: true));
    } else {
      List<JobReal2CariModel> jobReal2Cari = List.of(state.items)
        ..addAll(items);

      final result = jobReal2Cari
          .whereWithIndex((e, index) =>
              jobReal2Cari.indexWhere((e2) => e2.jobreal2Id == e.jobreal2Id) ==
              index)
          .toList();

      return emit(state.copyWith(
        items: result,
        hasReachedMax: false,
        status: ListStatus.success,
      ));
    }
  }  
}
