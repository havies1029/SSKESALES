import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/list_extension.dart';
import 'package:esalesapp/models/timeline/polisexpcari_model.dart';
import 'package:esalesapp/repositories/timeline/polisexpcari_repository.dart';

import '../../common/constants.dart';

part 'polisexpcari_event.dart';
part 'polisexpcari_state.dart';

class PolisExpCariBloc extends Bloc<PolisExpCariEvents, PolisExpCariState> {
	PolisExpCariBloc() : super(const PolisExpCariState()) {
		on<FetchPolisExpCariEvent>(onFetchPolisExpCari);
		on<RefreshPolisExpCariEvent>(onRefreshPolisExpCari);
	}

Future<void> onRefreshPolisExpCari(
		RefreshPolisExpCariEvent event, Emitter<PolisExpCariState> emit) async {
	emit(const PolisExpCariState());

	await Future.delayed(const Duration(seconds: 1));

	add(FetchPolisExpCariEvent(expgroupId: event.expgroupId, personalId: event.personalId,
    hal: event.hal, searchText: event.searchText));
}

Future<void> onFetchPolisExpCari(
		FetchPolisExpCariEvent event, Emitter<PolisExpCariState> emit) async {
	if (state.hasReachedMax) return;

	PolisExpCariRepository repo = PolisExpCariRepository();
	if (state.status == ListStatus.initial) {
		List<PolisExpCariModel> items = await repo.getPolisExpCari(event.searchText, event.hal,
      event.expgroupId, event.personalId);
		return emit(state.copyWith(
			items: items,
			hasReachedMax: false,
			status: ListStatus.success,
			));
	}
	List<PolisExpCariModel> items = await repo.getPolisExpCari(event.searchText, event.hal,
      event.expgroupId, event.personalId);
	if (items.isEmpty) {
		return emit(state.copyWith(hasReachedMax: true));
	} else {
		List<PolisExpCariModel> polisExpCari = List.of(state.items)..addAll(items);

		final result = polisExpCari
			.whereWithIndex((e, index) =>
				polisExpCari.indexWhere((e2) => e2.polis1Id == e.polis1Id) ==
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