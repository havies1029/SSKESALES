part of 'custcatcari_bloc.dart';

abstract class CustCatCariEvents extends Equatable {
	const CustCatCariEvents();

	@override
	List<Object> get props => [];
}

class FetchCustCatCariEvent extends CustCatCariEvents {
	final int hal;
	final String searchText;

	const FetchCustCatCariEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class RefreshCustCatCariEvent extends CustCatCariEvents {
	final int hal;
	final String searchText;

	const RefreshCustCatCariEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class UbahCustCatCariEvent extends CustCatCariEvents {
	final String recordId;

	const UbahCustCatCariEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class TambahCustCatCariEvent extends CustCatCariEvents{}
class HapusCustCatCariEvent extends CustCatCariEvents{}
class CloseDialogCustCatCariEvent extends CustCatCariEvents{}
