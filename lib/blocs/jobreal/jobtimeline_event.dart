part of 'jobtimeline_bloc.dart';

abstract class JobtimelineEvents extends Equatable {
	const JobtimelineEvents();

	@override
	List<Object> get props => [];
}

class FetchJobtimelineEvent extends JobtimelineEvents {

	const FetchJobtimelineEvent();

	@override
	List<Object> get props => [];
}

class RefreshJobtimelineEvent extends JobtimelineEvents {
	final String jobRealId;
	final String polisId;

	const RefreshJobtimelineEvent({required this.jobRealId, required this.polisId});

	@override
	List<Object> get props => [jobRealId, polisId];
}

