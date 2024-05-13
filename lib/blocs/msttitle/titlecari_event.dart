part of 'titlecari_bloc.dart';

abstract class TitleCariEvents extends Equatable {
	const TitleCariEvents();

	@override
	List<Object> get props => [];
}

class FetchTitleCariEvent extends TitleCariEvents {
	final int hal;
	final String searchText;

	const FetchTitleCariEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class RefreshTitleCariEvent extends TitleCariEvents {
	final int hal;
	final String searchText;

	const RefreshTitleCariEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class UbahTitleCariEvent extends TitleCariEvents {
	final String recordId;

	const UbahTitleCariEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class TambahTitleCariEvent extends TitleCariEvents{}
class HapusTitleCariEvent extends TitleCariEvents{}
class CloseDialogTitleCariEvent extends TitleCariEvents{}
