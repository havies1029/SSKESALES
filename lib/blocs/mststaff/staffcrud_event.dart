part of 'staffcrud_bloc.dart';

abstract class StaffCrudEvents extends Equatable {
	const StaffCrudEvents();

	@override
	List<Object> get props => [];
}

class StaffCrudTambahEvent extends StaffCrudEvents {
	final StaffCrudModel record;
	const StaffCrudTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class StaffCrudUbahEvent extends StaffCrudEvents {
	final StaffCrudModel record;
	const StaffCrudUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class StaffCrudHapusEvent extends StaffCrudEvents {
	final String recordId;
	const StaffCrudHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class StaffCrudLihatEvent extends StaffCrudEvents {
	final String recordId;
	const StaffCrudLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

