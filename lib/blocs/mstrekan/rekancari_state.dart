part of 'rekancari_bloc.dart';

class RekanCariState extends Equatable {
  final ListStatus status;
  final List<RekanCariModel> items;
  //final List<RekanCariModel> filteredItems;
  final bool hasReachedMax;
  final int hal;
  final String viewMode;
  final String recordId;
  final String filterBy;
  final String rekanTypeId;

  const RekanCariState(
      {this.status = ListStatus.initial,
      this.items = const <RekanCariModel>[],
      //this.filteredItems = const <RekanCariModel>[],
      this.hasReachedMax = false,
      this.hal = 0,
      this.viewMode = "",
      this.recordId = "",
      this.filterBy = "all",
      this.rekanTypeId = ""});

  RekanCariState copyWith(
      {List<RekanCariModel>? items,
      //List<RekanCariModel>? filteredItems,
      bool? hasReachedMax,
      ListStatus? status,
      int? hal,
      String? viewMode,
      String? recordId,
      String? filterBy,
      String? rekanTypeId}) {
    return RekanCariState(
        items: items ?? this.items,
        //filteredItems: filteredItems ?? this.filteredItems,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        status: status ?? this.status,
        hal: hal ?? this.hal,
        viewMode: viewMode ?? this.viewMode,
        recordId: recordId ?? this.recordId,
        filterBy: filterBy ?? this.filterBy,
        rekanTypeId: rekanTypeId ?? this.rekanTypeId);
  }

  @override
  List<Object> get props =>
      [status, items, hasReachedMax, hal, viewMode, recordId, filterBy, rekanTypeId];
}
