part of 'jobreal2cari_bloc.dart';

class JobReal2CariState extends Equatable {
  final ListStatus status;
  final List<JobReal2CariModel> items;
  final bool hasReachedMax;
  final bool isSaving;
  final bool isSaved;
  final bool hasFailure;
  final bool requestToUpdate;

  const JobReal2CariState({
    this.status = ListStatus.initial,
    this.items = const <JobReal2CariModel>[],
    this.hasReachedMax = false,
    this.isSaving = false,
    this.isSaved = false,
    this.hasFailure = false,
    this.requestToUpdate = false,
  });

  const JobReal2CariState.success(List<JobReal2CariModel> items)
      : this(status: ListStatus.success, items: items);

  const JobReal2CariState.failure() : this(status: ListStatus.failure);

  JobReal2CariState copyWith({
    List<JobReal2CariModel>? items,
    bool? hasReachedMax,
    ListStatus? status,
    bool? isSaving,
    bool? isSaved,
    bool? hasFailure,
    bool? requestToUpdate,
  }) {
    return JobReal2CariState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      isSaving: isSaving ?? this.isSaving,
      isSaved: isSaved ?? this.isSaved,
      hasFailure: hasFailure ?? this.hasFailure,
      requestToUpdate: requestToUpdate ?? this.requestToUpdate,
    );
  }

  @override
  List<Object> get props =>
      [status, items, hasReachedMax, isSaving, isSaved, 
        hasFailure, requestToUpdate];
}
