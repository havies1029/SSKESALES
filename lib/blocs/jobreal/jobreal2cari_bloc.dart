import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/list_extension.dart';
import 'package:esalesapp/models/jobreal/jobreal2cari_model.dart';
import 'package:esalesapp/repositories/jobreal/jobreal2cari_repository.dart';

part 'jobreal2cari_event.dart';
part 'jobreal2cari_state.dart';

class JobReal2CariBloc extends Bloc<JobReal2CariEvents, JobReal2CariState> {
  JobReal2CariBloc() : super(const JobReal2CariState()) {
    on<FetchJobReal2CariEvent>(onFetchJobReal2Cari);
    on<RefreshJobReal2CariEvent>(onRefreshJobReal2Cari);
  }

  Future<void> onRefreshJobReal2Cari(
      RefreshJobReal2CariEvent event, Emitter<JobReal2CariState> emit) async {
    emit(const JobReal2CariState());

    await Future.delayed(const Duration(seconds: 1));

    add(FetchJobReal2CariEvent(custId: event.custId, jobcatId: event.jobcatId, jobreal1Id: event.jobreal1Id));
  }

  Future<void> onFetchJobReal2Cari(
      FetchJobReal2CariEvent event, Emitter<JobReal2CariState> emit) async {
    if (state.hasReachedMax) return;

    JobReal2CariRepository repo = JobReal2CariRepository();
    if (state.status == ListStatus.initial) {
      List<JobReal2CariModel> items = await repo.getJobReal2Cari(
          event.custId, event.jobcatId, event.jobreal1Id);
      return emit(state.copyWith(
        items: items,
        hasReachedMax: false,
        status: ListStatus.success,
      ));
    }
    List<JobReal2CariModel> items = await repo.getJobReal2Cari(event.custId, event.jobcatId, event.jobreal1Id);
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
