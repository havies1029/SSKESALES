import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/models/mstrekan/rekancrud_model.dart';
import 'package:esalesapp/repositories/mstrekan/rekancrud_repository.dart';

part 'rekancrud_event.dart';
part 'rekancrud_state.dart';

class RekanCrudBloc extends Bloc<RekanCrudEvents, RekanCrudState> {
  final RekanCrudRepository repository;
  RekanCrudBloc({required this.repository}) : super(const RekanCrudState()) {
    on<RekanCrudUbahEvent>(onUbahRekanCrud);
    on<RekanCrudTambahEvent>(onTambahRekanCrud);
    on<RekanCrudHapusEvent>(onHapusRekanCrud);
    on<RekanCrudLihatEvent>(onLihatRekanCrud);
  }

  Future<void> onTambahRekanCrud(
      RekanCrudTambahEvent event, Emitter<RekanCrudState> emit) async {
    ReturnDataAPI returnData;
    bool hasFailure = true;
    emit(state.copyWith(isSaving: true, isSaved: false));
    returnData = await repository.rekanCrudTambah(event.record);
    hasFailure = !returnData.success;
    emit(
        state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
  }

  Future<void> onUbahRekanCrud(
      RekanCrudUbahEvent event, Emitter<RekanCrudState> emit) async {
    emit(state.copyWith(isSaving: true, isSaved: false));
    bool hasFailure = !await repository.rekanCrudUbah(event.record);
    emit(
        state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
  }

  Future<void> onHapusRekanCrud(
      RekanCrudHapusEvent event, Emitter<RekanCrudState> emit) async {
    emit(state.copyWith(isSaving: true, isSaved: false));
    bool hasFailure = !await repository.rekanCrudHapus(event.recordId);
    emit(
        state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
  }

  Future<void> onLihatRekanCrud(
      RekanCrudLihatEvent event, Emitter<RekanCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));

    RekanCrudModel record = await repository.rekanCrudLihat(event.recordId);

    emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
  }
}
