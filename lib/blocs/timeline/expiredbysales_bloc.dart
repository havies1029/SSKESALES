import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/list_extension.dart';
import 'package:esalesapp/models/timeline/expiredbysales_model.dart';
import 'package:esalesapp/repositories/timeline/expiredbysales_repository.dart';

import '../../common/constants.dart';

part 'expiredbysales_event.dart';
part 'expiredbysales_state.dart';

class ExpiredBySalesBloc extends Bloc<ExpiredBySalesEvents, ExpiredBySalesState> {
	ExpiredBySalesBloc() : super(const ExpiredBySalesState()) {
		on<FetchExpiredBySalesEvent>(onFetchExpiredBySales);
		on<RefreshExpiredBySalesEvent>(onRefreshExpiredBySales);
	}

Future<void> onRefreshExpiredBySales(
		RefreshExpiredBySalesEvent event, Emitter<ExpiredBySalesState> emit) async {
	emit(const ExpiredBySalesState());

	await Future.delayed(const Duration(seconds: 1));

	add(FetchExpiredBySalesEvent(expgroupId: event.expgroupId));
}

Future<void> onFetchExpiredBySales(
		FetchExpiredBySalesEvent event, Emitter<ExpiredBySalesState> emit) async {
	if (state.hasReachedMax) return;

	ExpiredBySalesRepository repo = ExpiredBySalesRepository();
	if (state.status == ListStatus.initial) {
		List<ExpiredBySalesModel> items = await repo.getExpiredBySales(event.expgroupId);
		return emit(state.copyWith(
			items: items,
			hasReachedMax: false,
			status: ListStatus.success,
			));
	}
	List<ExpiredBySalesModel> items = await repo.getExpiredBySales(event.expgroupId);
	if (items.isEmpty) {
		return emit(state.copyWith(hasReachedMax: true));
	} else {
		List<ExpiredBySalesModel> expiredBySales = List.of(state.items)..addAll(items);

		final result = expiredBySales
			.whereWithIndex((e, index) =>
				expiredBySales.indexWhere((e2) => e2.salesId == e.salesId) ==
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