part of 'jobreal2cari_bloc.dart';

abstract class JobReal2CariEvents extends Equatable {
	const JobReal2CariEvents();

	@override
	List<Object> get props => [];
}

class FetchJobReal2CariEvent extends JobReal2CariEvents {
  final String custId;
	final String? jobcatId;
	final String? jobreal1Id;

	const FetchJobReal2CariEvent({required this.custId, this.jobcatId, this.jobreal1Id});

	@override
	List<Object> get props => [custId];
}

class RefreshJobReal2CariEvent extends JobReal2CariEvents {
  final String custId;
	final String? jobcatId;
	final String? jobreal1Id;

	const RefreshJobReal2CariEvent({required this.custId, this.jobcatId, this.jobreal1Id});

	@override
	List<Object> get props => [custId];
}

