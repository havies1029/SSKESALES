import 'package:equatable/equatable.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/list_extension.dart';
import 'package:esalesapp/models/mstjob/jobsalescari_model.dart';
import 'package:esalesapp/repositories/mstjob/jobsalescari_repository.dart';

part 'jobsalescari_event.dart';
part 'jobsalescari_state.dart';

class JobSalesCariBloc extends Bloc<JobSalesCariEvents, JobSalesCariState> {
	JobSalesCariBloc() : super(const JobSalesCariState()) {
		on<FetchJobSalesCariEvent>(onFetchJobSalesCari);
		on<RefreshJobSalesCariEvent>(onRefreshJobSalesCari);
	}

Future<void> onRefreshJobSalesCari(
		RefreshJobSalesCariEvent event, Emitter<JobSalesCariState> emit) async {
	emit(const JobSalesCariState());

	await Future.delayed(const Duration(seconds: 1));

	add(FetchJobSalesCariEvent(hal: 0, searchText: event.searchText));
}

Future<void> onFetchJobSalesCari(
		FetchJobSalesCariEvent event, Emitter<JobSalesCariState> emit) async {
	if (state.hasReachedMax) return;

	JobSalesCariRepository repo = JobSalesCariRepository();
	if (state.status == ListStatus.initial) {
		List<JobSalesCariModel> items = await repo.getJobSalesCari(event.searchText, 0);
		return emit(state.copyWith(
			items: items,
			hasReachedMax: false,
			status: ListStatus.success,
			hal: 1));
	}
	List<JobSalesCariModel> items = await repo.getJobSalesCari(event.searchText, state.hal);
	if (items.isEmpty) {
		return emit(state.copyWith(hasReachedMax: true));
	} else {
		List<JobSalesCariModel> jobSalesCari = List.of(state.items)..addAll(items);

		final result = jobSalesCari
			.whereWithIndex((e, index) =>
				jobSalesCari.indexWhere((e2) => e2.personId == e.personId) ==
				index)
			.toList();

		return emit(state.copyWith(
			items: result,
			hasReachedMax: false,
			status: ListStatus.success,
			hal: state.hal + 1));
		}

	}
}