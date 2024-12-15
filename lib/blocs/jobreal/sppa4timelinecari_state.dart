part of 'sppa4timelinecari_bloc.dart';

class SppaCariState extends Equatable {
  final String jobRealId;
  final String searchText;
  final ListStatus status;
  final List<SppaCariModel> items;
  final bool hasReachedMax;
  final int hal;

  const SppaCariState(
      { this.jobRealId = "", 
        this.searchText = "", 
        this.status = ListStatus.initial,
        this.items = const <SppaCariModel>[],
        this.hasReachedMax = false,
        this.hal = 0});

  const SppaCariState.success(List<SppaCariModel> items)
      : this(status: ListStatus.success, items: items);

  const SppaCariState.failure() : this(status: ListStatus.failure);

  SppaCariState copyWith(
      { String? jobRealId,
        String? searchText,
        List<SppaCariModel>? items,
        bool? hasReachedMax,
        ListStatus? status,
        int? hal}) {
    return SppaCariState(
        jobRealId: jobRealId ?? this.jobRealId,
        searchText: searchText ?? this.searchText,
        items: items ?? this.items,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        status: status ?? this.status,
        hal: hal ?? this.hal);
  }

  @override
  List<Object> get props => [jobRealId, searchText, status, items, hasReachedMax, hal];
}
