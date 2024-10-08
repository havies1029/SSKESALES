import 'package:equatable/equatable.dart';
import 'package:esalesapp/models/combobox/combojobcatgroup_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'jobrealglobal_state.dart';

class JobRealGlobalCubit extends Cubit<JobRealGlobalState> {
  JobRealGlobalCubit() : super(const JobRealGlobalState());

  Future<void> setSelectedJobCatGroup(ComboJobcatgroupModel jobCatGroup) async {
    emit(state.copyWith(selectedJobCatGroup: jobCatGroup));
  }
}
