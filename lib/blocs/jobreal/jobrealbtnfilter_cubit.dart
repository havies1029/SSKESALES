import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'jobrealbtnfilter_state.dart';

class JobRealBtnFilterCubit extends Cubit<JobRealBtnFilterState> {
  JobRealBtnFilterCubit() : super(const JobRealBtnFilterState());

  Future<void> setSelectedFilterDoc(String filterDoc) async {
    emit(state.copyWith(filterDoc: filterDoc));
  }
}
