part of 'jobrealtab_bloc.dart';

class JobRealTabState extends Equatable {
  final ListStatus status;
  final String jobCatGroupId;
  final List<ComboJobcatgroupModel> items;
  final List<Color>? colorCollection;
  final List<ComboJobcatgroupModel>? listJobCatGroup;
  final List<Widget>? listTab;

  const JobRealTabState(
      {this.status = ListStatus.initial,
      this.jobCatGroupId = "",
      this.items = const <ComboJobcatgroupModel>[],
      this.colorCollection,
      this.listJobCatGroup,
      this.listTab});

  const JobRealTabState.success(List<ComboJobcatgroupModel> items)
      : this(status: ListStatus.success, items: items);

  const JobRealTabState.failure() : this(status: ListStatus.failure);

  JobRealTabState copyWith(
      {List<ComboJobcatgroupModel>? items,
      String? jobCatGroupId,
      ListStatus? status,
      List<Color>? colorCollection,
      List<Widget>? listTab,
      List<ComboJobcatgroupModel>? listJobCatGroup}) {
    return JobRealTabState(
        items: items ?? this.items,
        jobCatGroupId: jobCatGroupId ?? this.jobCatGroupId,
        status: status ?? this.status,
        colorCollection: colorCollection ?? this.colorCollection,
        listTab: listTab ?? this.listTab,
        listJobCatGroup: listJobCatGroup ?? this.listJobCatGroup);
  }

  @override
  List<Object> get props => [status, items, jobCatGroupId];
}
