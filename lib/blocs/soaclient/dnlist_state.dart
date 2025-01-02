part of 'dnlist_bloc.dart';

class DnlistState extends Equatable {
  final ListStatus status;
  final List<DnlistModel> items;
  final bool hasReachedMax;
  final String soaAgingId;
  final String searchText;
  final int hal;
  final String selectedDNId;

  const DnlistState(
      {this.status = ListStatus.initial,
      this.items = const <DnlistModel>[],
      this.hasReachedMax = false,
      this.soaAgingId = "",
      this.searchText = "",
      this.hal = 0,
      this.selectedDNId = ""});

  const DnlistState.success(List<DnlistModel> items)
      : this(status: ListStatus.success, items: items);

  const DnlistState.failure() : this(status: ListStatus.failure);

  DnlistState copyWith(
      {List<DnlistModel>? items,
      bool? hasReachedMax,
      ListStatus? status,
      String? soaAgingId,
      String? searchText,
      int? hal,
      String? selectedDNId}) {
    return DnlistState(
        items: items ?? this.items,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        status: status ?? this.status,
        soaAgingId: soaAgingId ?? this.soaAgingId,
        searchText: searchText ?? this.searchText,
        hal: hal ?? this.hal,
        selectedDNId: selectedDNId ?? this.selectedDNId);
  }

  @override
  List<Object> get props =>
      [status, items, hasReachedMax, soaAgingId, searchText, hal, selectedDNId];
}
