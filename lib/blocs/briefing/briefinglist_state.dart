part of 'briefinglist_bloc.dart';

class BriefinglistState extends Equatable {
  final ListStatus status;
  final List<BriefinglistModel> items;
  final bool hasReachedMax;
  final ComboJobcatgroupModel? jobCatGroupOtherRecord;

  const BriefinglistState(
      {this.status = ListStatus.initial,
      this.items = const <BriefinglistModel>[],
      this.hasReachedMax = false,
      this.jobCatGroupOtherRecord,
    });

  const BriefinglistState.success(List<BriefinglistModel> items)
      : this(status: ListStatus.success, items: items);

  const BriefinglistState.failure() : this(status: ListStatus.failure);

  BriefinglistState copyWith(
      {List<BriefinglistModel>? items,
      bool? hasReachedMax,
      ListStatus? status,
      ComboJobcatgroupModel? jobCatGroupOtherRecord,
      BriefinglistModel? selectedItem,
      int? selectedIndex,
      bool? hasPassedBriefing}) {
    return BriefinglistState(
        items: items ?? this.items,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        status: status ?? this.status,
        jobCatGroupOtherRecord:
            jobCatGroupOtherRecord ?? this.jobCatGroupOtherRecord,
      );
  }

  @override
  List<Object> get props => [status, items, hasReachedMax];
}
