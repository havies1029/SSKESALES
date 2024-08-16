part of 'jobrealglobal_cubit.dart';

abstract class JobRealGlobalState extends Equatable {
  /*
  final ComboJobcatgroupModel selectedJobCatGroup;

  const JobRealGlobalState({required this.selectedJobCatGroup});

  JobRealGlobalState copyWith({ComboJobcatgroupModel? selectedJobCatGroup}) {
    return JobRealGlobalState(
        selectedJobCatGroup: selectedJobCatGroup ?? this.selectedJobCatGroup);
  }

  @override
  List<Object> get props => [selectedJobCatGroup];
  */
}

class InitialState extends JobRealGlobalState {
  @override
  List<Object> get props => [];
}

class LoadedState extends JobRealGlobalState {
  final ComboJobcatgroupModel selectedJobCatGroup;
  LoadedState(this.selectedJobCatGroup);
  
  @override
  List<Object> get props => [selectedJobCatGroup];
}
class ErrorState extends JobRealGlobalState {
  @override
  List<Object> get props => [];
}