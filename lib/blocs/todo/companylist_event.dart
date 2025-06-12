part of 'companylist_bloc.dart';

abstract class CompanyListEvents extends Equatable {
	const CompanyListEvents();

	@override
	List<Object> get props => [];
}

class FetchCompanyListEvent extends CompanyListEvents {}

class RefreshCompanyListEvent extends CompanyListEvents {
	final int hal;
	final String timeline1Id;

	const RefreshCompanyListEvent({required this.hal, required this.timeline1Id});

	@override
	List<Object> get props => [hal, timeline1Id];
}

class UbahCompanyListEvent extends CompanyListEvents {
	final String recordId;

	const UbahCompanyListEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class TambahCompanyListEvent extends CompanyListEvents{}
class HapusCompanyListEvent extends CompanyListEvents{}
class CloseDialogCompanyListEvent extends CompanyListEvents{}
