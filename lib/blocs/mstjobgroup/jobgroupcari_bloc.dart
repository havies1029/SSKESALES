import 'package:equatable/equatable.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/list_extension.dart';
import 'package:esalesapp/models/mstjobgroup/jobgroupcari_model.dart';
import 'package:esalesapp/repositories/mstjobgroup/jobgroupcari_repository.dart';

part 'jobgroupcari_event.dart';
part 'jobgroupcari_state.dart';

class JobGroupCariBloc extends Bloc<JobGroupCariEvents, JobGroupCariState> {
	JobGroupCariBloc() : super(const JobGroupCariState()) {
		on<FetchJobGroupCariEvent>(onFetchJobGroupCari);
		on<RefreshJobGroupCariEvent>(onRefreshJobGroupCari);
		on<UbahJobGroupCariEvent>(onUbahJobGroupCari);
		on<TambahJobGroupCariEvent>(onTambahJobGroupCari);
		on<HapusJobGroupCariEvent>(onHapusJobGroupCari);
		on<CloseDialogJobGroupCariEvent>(onCloseDialogJobGroupCari);
	}

	Future<void> onRefreshJobGroupCari(
			RefreshJobGroupCariEvent event, Emitter<JobGroupCariState> emit) async {
		emit(const JobGroupCariState());

		await Future.delayed(const Duration(seconds: 1));

		add(FetchJobGroupCariEvent(hal: 0, searchText: event.searchText));
	}

	Future<void> onFetchJobGroupCari(
			FetchJobGroupCariEvent event, Emitter<JobGroupCariState> emit) async {
		if (state.hasReachedMax) return;

		JobGroupCariRepository repo = JobGroupCariRepository();
		if (state.status == ListStatus.initial) {
			List<JobGroupCariModel> items = await repo.getJobGroupCari(event.searchText, 0);
			return emit(state.copyWith(
				items: items,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: 1));
		}
		List<JobGroupCariModel> items = await repo.getJobGroupCari(event.searchText, state.hal);
		if (items.isEmpty) {
			return emit(state.copyWith(hasReachedMax: true));
		} else {
			List<JobGroupCariModel> jobGroupCari = List.of(state.items)..addAll(items);

			final result = jobGroupCari
				.whereWithIndex((e, index) =>
					jobGroupCari.indexWhere((e2) => e2.mjobgroupId == e.mjobgroupId) ==
					index)
				.toList();

			return emit(state.copyWith(
				items: result,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: state.hal + 1));
		}
	}

	Future<void> onHapusJobGroupCari(
		HapusJobGroupCariEvent event, Emitter<JobGroupCariState> emit) async {
		return emit(state.copyWith(viewMode: "hapus"));
	}

	Future<void> onCloseDialogJobGroupCari(
		CloseDialogJobGroupCariEvent event, Emitter<JobGroupCariState> emit) async {
		return emit(state.copyWith(viewMode: ""));
	}

	Future<void> onTambahJobGroupCari(
		TambahJobGroupCariEvent event, Emitter<JobGroupCariState> emit) async {
		return emit(state.copyWith(viewMode: "tambah"));
	}

	Future<void> onUbahJobGroupCari(
		UbahJobGroupCariEvent event, Emitter<JobGroupCariState> emit) async {
		return emit(state.copyWith(viewMode: "ubah", recordId: event.recordId));
	}

}