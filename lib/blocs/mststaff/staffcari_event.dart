part of 'staffcari_bloc.dart';

abstract class StaffCariEvents extends Equatable {
	const StaffCariEvents();

	@override
	List<Object> get props => [];
}

class FetchStaffCariEvent extends StaffCariEvents {
	final int hal;
	final String searchText;

	const FetchStaffCariEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class RefreshStaffCariEvent extends StaffCariEvents {
	final int hal;
	final String searchText;

	const RefreshStaffCariEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class UbahStaffCariEvent extends StaffCariEvents {
	final String recordId;

	const UbahStaffCariEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class TambahStaffCariEvent extends StaffCariEvents{}
class HapusStaffCariEvent extends StaffCariEvents{}
class CloseDialogStaffCariEvent extends StaffCariEvents{}
