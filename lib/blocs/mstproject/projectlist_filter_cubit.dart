import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'projectlist_filter_state.dart';

class ProjectlistFilterCubit extends Cubit<ProjectlistFilterState> {
  ProjectlistFilterCubit() : super(ProjectlistFilterState());

  Future<void> setRekanId(String rekanId) async {
    emit(state.copyWith(rekanId: rekanId));
  }

  Future<void> setSearchText(String searchText) async {
    emit(state.copyWith(searchText: searchText));
  }
}
