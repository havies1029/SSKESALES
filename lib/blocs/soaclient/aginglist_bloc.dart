import 'package:equatable/equatable.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/list_extension.dart';
import 'package:esalesapp/models/soaclient/aginglist_model.dart';
import 'package:esalesapp/repositories/soaclient/aginglist_repository.dart';

part 'aginglist_event.dart';
part 'aginglist_state.dart';

class AginglistBloc extends Bloc<AginglistEvents, AginglistState> {
	AginglistBloc() : super(const AginglistState()) {
		on<FetchAginglistEvent>(onFetchAginglist);
		on<RefreshAginglistEvent>(onRefreshAginglist);
	}

Future<void> onRefreshAginglist(
		RefreshAginglistEvent event, Emitter<AginglistState> emit) async {
	emit(const AginglistState());

	await Future.delayed(const Duration(seconds: 1));

	add(FetchAginglistEvent());
}

Future<void> onFetchAginglist(
		FetchAginglistEvent event, Emitter<AginglistState> emit) async {
	if (state.hasReachedMax) return;

	AginglistRepository repo = AginglistRepository();
	if (state.status == ListStatus.initial) {
		List<AginglistModel> items = await repo.getAginglist();
		return emit(state.copyWith(
			items: items,
			hasReachedMax: false,
			status: ListStatus.success,
			));
	}
	List<AginglistModel> items = await repo.getAginglist();
	if (items.isEmpty) {
		return emit(state.copyWith(hasReachedMax: true));
	} else {
		List<AginglistModel> aginglist = List.of(state.items)..addAll(items);

		final result = aginglist
			.whereWithIndex((e, index) =>
				aginglist.indexWhere((e2) => e2.msoaagingId == e.msoaagingId) ==
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