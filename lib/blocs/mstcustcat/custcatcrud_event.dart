part of 'custcatcrud_bloc.dart';

abstract class CustCatCrudEvents extends Equatable {
	const CustCatCrudEvents();

	@override
	List<Object> get props => [];
}

class CustCatCrudTambahEvent extends CustCatCrudEvents {
	final CustCatCrudModel record;
	const CustCatCrudTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class CustCatCrudUbahEvent extends CustCatCrudEvents {
	final CustCatCrudModel record;
	const CustCatCrudUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class CustCatCrudHapusEvent extends CustCatCrudEvents {
	final String recordId;
	const CustCatCrudHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class CustCatCrudLihatEvent extends CustCatCrudEvents {
	final String recordId;
	const CustCatCrudLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

