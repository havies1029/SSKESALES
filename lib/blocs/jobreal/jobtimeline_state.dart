part of 'jobtimeline_bloc.dart';

class JobtimelineState extends Equatable {
  final ListStatus status;
  final List<JobtimelineModel> items;
  final bool hasReachedMax;
  final int hal;
  final String jobRealId;
  final String polisId;

  const JobtimelineState(
      {this.status = ListStatus.initial,
      this.items = const <JobtimelineModel>[],
      this.hasReachedMax = false,
      this.hal = 0,
      this.jobRealId = "", 
      this.polisId = "" });

  const JobtimelineState.success(List<JobtimelineModel> items)
      : this(status: ListStatus.success, items: items);

  const JobtimelineState.failure() : this(status: ListStatus.failure);

  JobtimelineState copyWith(
      {List<JobtimelineModel>? items,
      bool? hasReachedMax,
      ListStatus? status,
      int? hal,
      String? jobRealId,
      String? polisId}) {
    return JobtimelineState(
        items: items ?? this.items,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        status: status ?? this.status,
        hal: hal ?? this.hal,
        jobRealId: jobRealId ?? this.jobRealId,
        polisId: polisId ?? this.polisId);
  }

  @override
  List<Object> get props => [status, items, hasReachedMax, hal, jobRealId, polisId];
}
