part of 'jobreal2list_bloc.dart';

abstract class JobReal2ListEvents extends Equatable {
	const JobReal2ListEvents();

	@override
	List<Object> get props => [];
}

class FetchJobReal2ListEvent extends JobReal2ListEvents {
	final String jobreal1Id;

	const FetchJobReal2ListEvent({required this.jobreal1Id});

	@override
	List<Object> get props => [jobreal1Id];
}

class RefreshJobReal2ListEvent extends JobReal2ListEvents {  
	final String jobreal1Id;

	const RefreshJobReal2ListEvent({required this.jobreal1Id});

	@override
	List<Object> get props => [jobreal1Id];
}

