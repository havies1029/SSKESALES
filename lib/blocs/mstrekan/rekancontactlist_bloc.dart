import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/widgets/list_extension.dart';
import 'package:esalesapp/models/mstrekan/rekancontactlist_model.dart';
import 'package:esalesapp/repositories/mstrekan/rekancontactlist_repository.dart';

part 'rekancontactlist_event.dart';
part 'rekancontactlist_state.dart';

class RekanContactListBloc
    extends Bloc<RekanContactListEvents, RekanContactListState> {
  RekanContactListBloc() : super(const RekanContactListState()) {
    on<FetchRekanContactListEvent>(onFetchRekanContactList);
    on<RefreshRekanContactListEvent>(onRefreshRekanContactList);
    on<UbahRekanContactListEvent>(onUbahRekanContactList);
    on<TambahRekanContactListEvent>(onTambahRekanContactList);
    on<HapusRekanContactListEvent>(onHapusRekanContactList);
    on<CloseDialogRekanContactListEvent>(onCloseDialogRekanContactList);
  }

  Future<void> onRefreshRekanContactList(RefreshRekanContactListEvent event,
      Emitter<RekanContactListState> emit) async {
    emit(const RekanContactListState());

    emit(state.copyWith(mrekanId: event.mrekanId));

    add(FetchRekanContactListEvent());
  }

  Future<void> onFetchRekanContactList(FetchRekanContactListEvent event,
      Emitter<RekanContactListState> emit) async {
    if (state.hasReachedMax) return;

    RekanContactListRepository repo = RekanContactListRepository();
    if (state.status == ListStatus.initial) {
      List<RekanContactListModel> items =
          await repo.getRekanContactList(state.mrekanId, 0);
      return emit(state.copyWith(
          items: items,
          hasReachedMax: false,
          status: ListStatus.success,
          hal: 1));
    }
    List<RekanContactListModel> items =
        await repo.getRekanContactList(state.mrekanId, state.hal);
    if (items.isEmpty) {
      return emit(state.copyWith(hasReachedMax: true));
    } else {
      List<RekanContactListModel> rekanContactList = List.of(state.items)
        ..addAll(items);

      final result = rekanContactList
          .whereWithIndex((e, index) =>
              rekanContactList
                  .indexWhere((e2) => e2.mcontactId == e.mcontactId) ==
              index)
          .toList();

      return emit(state.copyWith(
          items: result,
          hasReachedMax: false,
          status: ListStatus.success,
          hal: state.hal + 1));
    }
  }

  Future<void> onHapusRekanContactList(HapusRekanContactListEvent event,
      Emitter<RekanContactListState> emit) async {
        
    emit(state.copyWith(viewMode: ""));
    emit(state.copyWith(viewMode: "hapus"));
  }

  Future<void> onCloseDialogRekanContactList(
      CloseDialogRekanContactListEvent event,
      Emitter<RekanContactListState> emit) async {
    emit(state.copyWith(viewMode: ""));
  }

  Future<void> onTambahRekanContactList(TambahRekanContactListEvent event,
      Emitter<RekanContactListState> emit) async {
    emit(state.copyWith(viewMode: ""));
    emit(state.copyWith(viewMode: "tambah"));
  }

  Future<void> onUbahRekanContactList(UbahRekanContactListEvent event,
      Emitter<RekanContactListState> emit) async {
        
    emit(state.copyWith(viewMode: ""));
    emit(state.copyWith(viewMode: "ubah", recordId: event.recordId));
  }
}
