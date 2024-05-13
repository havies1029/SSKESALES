part of 'mediacrud_bloc.dart';

abstract class MediaCrudEvents extends Equatable {
	const MediaCrudEvents();

	@override
	List<Object> get props => [];
}

class MediaCrudTambahEvent extends MediaCrudEvents {
	final MediaCrudModel record;
	const MediaCrudTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class MediaCrudUbahEvent extends MediaCrudEvents {
	final MediaCrudModel record;
	const MediaCrudUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class MediaCrudHapusEvent extends MediaCrudEvents {
	final String recordId;
	const MediaCrudHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class MediaCrudLihatEvent extends MediaCrudEvents {
	final String recordId;
	const MediaCrudLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

