part of 'jobrealtab_bloc.dart';

abstract class JobRealTabEvents extends Equatable {
	const JobRealTabEvents();

	@override
	List<Object> get props => [];
}

class RefreshJobRealTabEvent extends JobRealTabEvents {
  final String personId;

  const RefreshJobRealTabEvent({required this.personId});

	@override
	List<Object> get props => [personId];
}

class SelectedJobRealTabEvent extends JobRealTabEvents {
  final String jobCatGroupId;

  const SelectedJobRealTabEvent({required this.jobCatGroupId});

	@override
	List<Object> get props => [jobCatGroupId];
}