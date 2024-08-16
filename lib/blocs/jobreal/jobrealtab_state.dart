part of 'jobrealtab_bloc.dart';

class JobRealTabState extends Equatable {
  final ListStatus status;
  final String jobCatGroupId;
  final List<ComboJobcatgroupModel> items;

  const JobRealTabState(
      {this.status = ListStatus.initial,
      this.jobCatGroupId = "",
      this.items = const <ComboJobcatgroupModel>[]});

  const JobRealTabState.success(List<ComboJobcatgroupModel> items)
      : this(status: ListStatus.success, items: items);

  const JobRealTabState.failure() : this(status: ListStatus.failure);

  JobRealTabState copyWith(
      {List<ComboJobcatgroupModel>? items, 
      String? jobCatGroupId,
      ListStatus? status}) {
    return JobRealTabState(
        items: items ?? this.items, 
        jobCatGroupId: jobCatGroupId ?? this.jobCatGroupId, 
        status: status ?? this.status);
  }

  @override
  List<Object> get props => [status, items, jobCatGroupId];
}
