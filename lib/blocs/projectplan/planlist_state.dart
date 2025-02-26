part of 'planlist_bloc.dart';

class PlanListState extends Equatable {
  final ListStatus status;
  final List<PlanListModel> items;
  final bool hasReachedMax;
  final int hal;
  final String viewMode;
  final String searchText;
  final String recordId;
  final String projectId;

  const PlanListState( 
      {this.status = ListStatus.initial,
      this.items = const <PlanListModel>[],
      this.hasReachedMax = false,
      this.hal = 0,
      this.viewMode = "",
      this.searchText = "",
      this.recordId = "",
      this.projectId = ""});

  PlanListState copyWith(
      {List<PlanListModel>? items,
      bool? hasReachedMax,
      ListStatus? status,
      int? hal,
      String? viewMode,
      String? searchText,
      String? recordId,
      String? projectId}) {
    return PlanListState(
        items: items ?? this.items,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        status: status ?? this.status,
        hal: hal ?? this.hal,
        viewMode: viewMode ?? this.viewMode,
        searchText: searchText ?? this.searchText,
        recordId: recordId ?? this.recordId,
        projectId: projectId ?? this.projectId);
  }

  @override
  List<Object> get props =>
      [status, items, hasReachedMax, hal, viewMode, recordId, searchText, projectId];
}
