part of 'titlecrud_bloc.dart';

abstract class TitleCrudEvents extends Equatable {
	const TitleCrudEvents();

	@override
	List<Object> get props => [];
}

class TitleCrudTambahEvent extends TitleCrudEvents {
	final TitleCrudModel record;
	const TitleCrudTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class TitleCrudUbahEvent extends TitleCrudEvents {
	final TitleCrudModel record;
	const TitleCrudUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class TitleCrudHapusEvent extends TitleCrudEvents {
	final String recordId;
	const TitleCrudHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class TitleCrudLihatEvent extends TitleCrudEvents {
	final String recordId;
	const TitleCrudLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

