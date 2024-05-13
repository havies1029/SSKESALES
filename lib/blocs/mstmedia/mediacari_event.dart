part of 'mediacari_bloc.dart';

abstract class MediaCariEvents extends Equatable {
	const MediaCariEvents();

	@override
	List<Object> get props => [];
}

class FetchMediaCariEvent extends MediaCariEvents {
	final int hal;
	final String searchText;

	const FetchMediaCariEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class RefreshMediaCariEvent extends MediaCariEvents {
	final int hal;
	final String searchText;

	const RefreshMediaCariEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class UbahMediaCariEvent extends MediaCariEvents {
	final String recordId;

	const UbahMediaCariEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class TambahMediaCariEvent extends MediaCariEvents{}
class HapusMediaCariEvent extends MediaCariEvents{}
class CloseDialogMediaCariEvent extends MediaCariEvents{}
