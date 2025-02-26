import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/widgets/list_extension.dart';
import 'package:esalesapp/models/projectplan/planlist_model.dart';
import 'package:esalesapp/repositories/projectplan/planlist_repository.dart';

part 'planlist_event.dart';
part 'planlist_state.dart';

class PlanListBloc extends Bloc<PlanListEvents, PlanListState> {
	PlanListBloc() : super(const PlanListState()) {
		on<FetchPlanListEvent>(onFetchPlanList);
		on<RefreshPlanListEvent>(onRefreshPlanList);
		on<UbahPlanListEvent>(onUbahPlanList);
		on<TambahPlanListEvent>(onTambahPlanList);
		on<HapusPlanListEvent>(onHapusPlanList);
		on<CloseDialogPlanListEvent>(onCloseDialogPlanList);
	}

	Future<void> onRefreshPlanList(
			RefreshPlanListEvent event, Emitter<PlanListState> emit) async {
		emit(const PlanListState());

		emit(state.copyWith(projectId: event.projectId));

		add(FetchPlanListEvent());
	}

	Future<void> onFetchPlanList(
			FetchPlanListEvent event, Emitter<PlanListState> emit) async {
		if (state.hasReachedMax) return;

		PlanListRepository repo = PlanListRepository();
		if (state.status == ListStatus.initial) {
			List<PlanListModel> items = await repo.getPlanList(state.projectId, 0);
			return emit(state.copyWith(
				items: items,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: 1));
		}
		List<PlanListModel> items = await repo.getPlanList(state.projectId, state.hal);
		if (items.isEmpty) {
			return emit(state.copyWith(hasReachedMax: true));
		} else {
			List<PlanListModel> planList = List.of(state.items)..addAll(items);

			final result = planList
				.whereWithIndex((e, index) =>
					planList.indexWhere((e2) => e2.plan1Id == e.plan1Id) ==
					index)
				.toList();

			return emit(state.copyWith(
				items: result,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: state.hal + 1));
		}
	}

	Future<void> onHapusPlanList(
		HapusPlanListEvent event, Emitter<PlanListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "hapus"));
	}

	Future<void> onCloseDialogPlanList(
		CloseDialogPlanListEvent event, Emitter<PlanListState> emit) async {
		emit(state.copyWith(viewMode: ""));
	}

	Future<void> onTambahPlanList(
		TambahPlanListEvent event, Emitter<PlanListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "tambah"));
	}

	Future<void> onUbahPlanList(
		UbahPlanListEvent event, Emitter<PlanListState> emit) async {
		emit(state.copyWith(viewMode: ""));
		emit(state.copyWith(viewMode: "ubah", recordId: event.recordId));
	}

}