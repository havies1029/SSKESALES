import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/list_extension.dart';
import 'package:esalesapp/models/assignment/clientassigncari_model.dart';
import 'package:esalesapp/repositories/assignment/clientassigncari_repository.dart';

import '../../common/constants.dart';

part 'clientassigncari_event.dart';
part 'clientassigncari_state.dart';

class ClientAssignCariBloc extends Bloc<ClientAssignCariEvents, ClientAssignCariState> {
	ClientAssignCariBloc() : super(const ClientAssignCariState()) {
		on<FetchClientAssignCariEvent>(onFetchClientAssignCari);
		on<RefreshClientAssignCariEvent>(onRefreshClientAssignCari);
	}

Future<void> onRefreshClientAssignCari(
		RefreshClientAssignCariEvent event, Emitter<ClientAssignCariState> emit) async {
	emit(const ClientAssignCariState());

	await Future.delayed(const Duration(seconds: 1));

	add(FetchClientAssignCariEvent());
}

Future<void> onFetchClientAssignCari(
		FetchClientAssignCariEvent event, Emitter<ClientAssignCariState> emit) async {
	if (state.hasReachedMax) return;

	ClientAssignCariRepository repo = ClientAssignCariRepository();
	if (state.status == ListStatus.initial) {
		List<ClientAssignCariModel> items = await repo.getClientAssignCari();
		return emit(state.copyWith(
			items: items,
			hasReachedMax: false,
			status: ListStatus.success,
			));
	}
	List<ClientAssignCariModel> items = await repo.getClientAssignCari();
	if (items.isEmpty) {
		return emit(state.copyWith(hasReachedMax: true));
	} else {
		List<ClientAssignCariModel> clientAssignCari = List.of(state.items)..addAll(items);

		final result = clientAssignCari
			.whereWithIndex((e, index) =>
				clientAssignCari.indexWhere((e2) => e2.clientId == e.clientId) ==
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