part of 'jobreal3cari_bloc.dart';

class JobReal3CariState extends Equatable {
  final ListStatus status;
  final List<JobReal3CariModel> items;
  final bool hasReachedMax;
  final bool isSaving;
  final bool isSaved;
  final bool hasFailure;
	final int hal;
  final bool requestToUpdate;
  const JobReal3CariState({
    this.status = ListStatus.initial,
    this.items = const <JobReal3CariModel>[],
    this.hasReachedMax = false,
    this.isSaving = false,
    this.isSaved = false,
    this.hasFailure = false,
		this.hal = 0,
    this.requestToUpdate = false,
  });

  const JobReal3CariState.success(List<JobReal3CariModel> items)
      : this(status: ListStatus.success, items: items);

  const JobReal3CariState.failure() : this(status: ListStatus.failure);

  JobReal3CariState copyWith({
    List<JobReal3CariModel>? items,
    bool? hasReachedMax,
    ListStatus? status,
		int? hal,
    bool? isSaving,
    bool? isSaved,
    bool? hasFailure,
    bool? requestToUpdate,
  }) {
    return JobReal3CariState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
			hal: hal ?? this.hal,
      isSaving: isSaving ?? this.isSaving,
      isSaved: isSaved ?? this.isSaved,
      hasFailure: hasFailure ?? this.hasFailure,
      requestToUpdate: requestToUpdate ?? this.requestToUpdate,
    );
  }

  @override
  List<Object> get props => [status, items, hasReachedMax, isSaving, isSaved, 
        hasFailure, requestToUpdate, hal];
}
