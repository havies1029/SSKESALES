part of 'jabatancrud_bloc.dart';

abstract class JabatanCrudEvents extends Equatable {
	const JabatanCrudEvents();

	@override
	List<Object> get props => [];
}

class JabatanCrudTambahEvent extends JabatanCrudEvents {
	final JabatanCrudModel record;
	const JabatanCrudTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class JabatanCrudUbahEvent extends JabatanCrudEvents {
	final JabatanCrudModel record;
	const JabatanCrudUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class JabatanCrudHapusEvent extends JabatanCrudEvents {
	final String recordId;
	const JabatanCrudHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class JabatanCrudLihatEvent extends JabatanCrudEvents {
	final String recordId;
	const JabatanCrudLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

