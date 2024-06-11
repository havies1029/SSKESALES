part of 'jobrealcari_bloc.dart';

abstract class JobRealCariEvents extends Equatable {
  const JobRealCariEvents();

  @override
  List<Object> get props => [];
}

class FetchJobRealCariEvent extends JobRealCariEvents {
  final int hal;
  final String searchText;
  final String filterDoc;

  const FetchJobRealCariEvent({required this.hal, required this.searchText, required this.filterDoc});

  @override
  List<Object> get props => [hal, searchText, filterDoc];
}

class RefreshJobRealCariEvent extends JobRealCariEvents {
  final String personId;
  final int hal;
  final String searchText;
  final String filterDoc;

  const RefreshJobRealCariEvent({required this.hal, 
  required this.searchText, required this.filterDoc,
  required this.personId});

  @override
  List<Object> get props => [hal, searchText, filterDoc, personId];
}

class UbahJobRealCariEvent extends JobRealCariEvents {
  final String recordId;

  const UbahJobRealCariEvent({required this.recordId});

  @override
  List<Object> get props => [recordId];
}

class LihatJobRealCariEvent extends JobRealCariEvents {
  final String recordId;

  const LihatJobRealCariEvent({required this.recordId});

  @override
  List<Object> get props => [recordId];
}

class TambahJobRealCariEvent extends JobRealCariEvents {}

class CloseDialogJobRealCariEvent extends JobRealCariEvents {}

class ResetStateJobRealCariEvent extends JobRealCariEvents {  
  final String personId;
  const ResetStateJobRealCariEvent({required this.personId});

  @override
  List<Object> get props => [personId];
}

class SetFilterDocRealCariEvent extends JobRealCariEvents {
  final String filterDoc;

  const SetFilterDocRealCariEvent({required this.filterDoc});

  @override
  List<Object> get props => [filterDoc];
}

class JobRealDuplicateEvent extends JobRealCariEvents {
	final String recordId;
	const JobRealDuplicateEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}