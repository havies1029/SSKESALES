part of 'jobreal2grid_bloc.dart';

class JobReal2GridState extends Equatable {
  final ListStatus status;
  final List<JobReal2CariModel> items;
  final bool hasReachedMax;
  final hal;
  const JobReal2GridState({
    this.status = ListStatus.initial,
    this.items = const <JobReal2CariModel>[],
    this.hasReachedMax = false,
    this.hal = 0
  });

  const JobReal2GridState.success(List<JobReal2CariModel> items)
      : this(status: ListStatus.success, items: items);

  const JobReal2GridState.failure() : this(status: ListStatus.failure);

  JobReal2GridState copyWith({
    List<JobReal2CariModel>? items,
    bool? hasReachedMax,
    ListStatus? status,
    int? hal
  }) {
    return JobReal2GridState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      hal: hal?? this.hal
    );
  }

  @override
  List<Object> get props => [status, items, hasReachedMax, hal];
}
