part of 'jobrealcari_bloc.dart';

class JobRealCariState extends Equatable {
  final ListStatus status;
  final List<JobRealCariModel> items;
  final bool hasReachedMax;
  final int hal;
  final String viewMode;
  final String recordId;
  final String filterDoc;
  final bool requestToRefresh;

  const JobRealCariState(
      {this.status = ListStatus.initial,
      this.items = const <JobRealCariModel>[],
      this.hasReachedMax = false,
      this.hal = 0,
      this.viewMode = "",
      this.recordId = "",
      this.filterDoc = "all",
      this.requestToRefresh = false});

  const JobRealCariState.success(List<JobRealCariModel> items)
      : this(status: ListStatus.success, items: items);

  const JobRealCariState.failure() : this(status: ListStatus.failure);

  JobRealCariState copyWith(
      {List<JobRealCariModel>? items,
      bool? hasReachedMax,
      ListStatus? status,
      int? hal,
      String? viewMode,
      String? recordId,
      String? filterDoc,
      bool? requestToRefresh}) {
    return JobRealCariState(
        items: items ?? this.items,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        status: status ?? this.status,
        hal: hal ?? this.hal,
        viewMode: viewMode ?? this.viewMode,
        recordId: recordId ?? this.recordId,
        filterDoc: filterDoc ?? this.filterDoc,
        requestToRefresh: requestToRefresh ?? this.requestToRefresh);
  }

  @override
  List<Object> get props =>
      [status, items, hasReachedMax, hal, viewMode, recordId, filterDoc, requestToRefresh];
}
