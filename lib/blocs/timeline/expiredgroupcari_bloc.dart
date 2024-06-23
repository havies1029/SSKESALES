import 'package:equatable/equatable.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/list_extension.dart';
import 'package:esalesapp/models/timeline/expiredgroupcari_model.dart';
import 'package:esalesapp/repositories/timeline/expiredgroupcari_repository.dart';

part 'expiredgroupcari_event.dart';
part 'expiredgroupcari_state.dart';

class ExpiredGroupCariBloc extends Bloc<ExpiredGroupCariEvents, ExpiredGroupCariState> {
	ExpiredGroupCariBloc() : super(const ExpiredGroupCariState()) {
		on<FetchExpiredGroupCariEvent>(onFetchExpiredGroupCari);
		on<RefreshExpiredGroupCariEvent>(onRefreshExpiredGroupCari);
	}

Future<void> onRefreshExpiredGroupCari(
		RefreshExpiredGroupCariEvent event, Emitter<ExpiredGroupCariState> emit) async {
	emit(const ExpiredGroupCariState());

	await Future.delayed(const Duration(seconds: 1));

	add(FetchExpiredGroupCariEvent());
}

Future<void> onFetchExpiredGroupCari(
		FetchExpiredGroupCariEvent event, Emitter<ExpiredGroupCariState> emit) async {
	if (state.hasReachedMax) return;

	ExpiredGroupCariRepository repo = ExpiredGroupCariRepository();
	if (state.status == ListStatus.initial) {
		List<ExpiredGroupCariModel> items = await repo.getExpiredGroupCari();
		return emit(state.copyWith(
			items: items,
			hasReachedMax: false,
			status: ListStatus.success,      
			));
	}
	List<ExpiredGroupCariModel> items = await repo.getExpiredGroupCari();
	if (items.isEmpty) {
		return emit(state.copyWith(hasReachedMax: true));
	} else {
		List<ExpiredGroupCariModel> expiredGroupCari = List.of(state.items)..addAll(items);

		final result = expiredGroupCari
			.whereWithIndex((e, index) =>
				expiredGroupCari.indexWhere((e2) => e2.expgroupId == e.expgroupId) ==
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