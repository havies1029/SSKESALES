import 'package:equatable/equatable.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/list_extension.dart';
import 'package:esalesapp/models/mstjobcat/jobcatcari_model.dart';
import 'package:esalesapp/repositories/mstjobcat/jobcatcari_repository.dart';

part 'jobcatcari_event.dart';
part 'jobcatcari_state.dart';

class JobCatCariBloc extends Bloc<JobCatCariEvents, JobCatCariState> {
	JobCatCariBloc() : super(const JobCatCariState()) {
		on<FetchJobCatCariEvent>(onFetchJobCatCari);
		on<RefreshJobCatCariEvent>(onRefreshJobCatCari);
		on<UbahJobCatCariEvent>(onUbahJobCatCari);
		on<TambahJobCatCariEvent>(onTambahJobCatCari);
		on<HapusJobCatCariEvent>(onHapusJobCatCari);
		on<CloseDialogJobCatCariEvent>(onCloseDialogJobCatCari);
	}

	Future<void> onRefreshJobCatCari(
			RefreshJobCatCariEvent event, Emitter<JobCatCariState> emit) async {
		emit(const JobCatCariState());

		await Future.delayed(const Duration(seconds: 1));

		add(FetchJobCatCariEvent(hal: 0, searchText: event.searchText));
	}

	Future<void> onFetchJobCatCari(
			FetchJobCatCariEvent event, Emitter<JobCatCariState> emit) async {
		if (state.hasReachedMax) return;

		JobCatCariRepository repo = JobCatCariRepository();
		if (state.status == ListStatus.initial) {
			List<JobCatCariModel> items = await repo.getJobCatCari(event.searchText, 0);
			return emit(state.copyWith(
				items: items,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: 1));
		}
		List<JobCatCariModel> items = await repo.getJobCatCari(event.searchText, state.hal);
		if (items.isEmpty) {
			return emit(state.copyWith(hasReachedMax: true));
		} else {
			List<JobCatCariModel> jobCatCari = List.of(state.items)..addAll(items);

			final result = jobCatCari
				.whereWithIndex((e, index) =>
					jobCatCari.indexWhere((e2) => e2.mjobcatId == e.mjobcatId) ==
					index)
				.toList();

			return emit(state.copyWith(
				items: result,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: state.hal + 1));
		}
	}

	Future<void> onHapusJobCatCari(
		HapusJobCatCariEvent event, Emitter<JobCatCariState> emit) async {
		return emit(state.copyWith(viewMode: "hapus"));
	}

	Future<void> onCloseDialogJobCatCari(
		CloseDialogJobCatCariEvent event, Emitter<JobCatCariState> emit) async {
		return emit(state.copyWith(viewMode: ""));
	}

	Future<void> onTambahJobCatCari(
		TambahJobCatCariEvent event, Emitter<JobCatCariState> emit) async {
		return emit(state.copyWith(viewMode: "tambah"));
	}

	Future<void> onUbahJobCatCari(
		UbahJobCatCariEvent event, Emitter<JobCatCariState> emit) async {
		return emit(state.copyWith(viewMode: "ubah", recordId: event.recordId));
	}

}