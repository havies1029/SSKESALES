part of 'rekancontactlist_bloc.dart';

abstract class RekanContactListEvents extends Equatable {
	const RekanContactListEvents();

	@override
	List<Object> get props => [];
}

class FetchRekanContactListEvent extends RekanContactListEvents {}

class RefreshRekanContactListEvent extends RekanContactListEvents {
	final String mrekanId;

	const RefreshRekanContactListEvent({required this.mrekanId});

	@override
	List<Object> get props => [mrekanId];
}

class UbahRekanContactListEvent extends RekanContactListEvents {
	final String recordId;

	const UbahRekanContactListEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class TambahRekanContactListEvent extends RekanContactListEvents{}
class HapusRekanContactListEvent extends RekanContactListEvents{}
class CloseDialogRekanContactListEvent extends RekanContactListEvents{}
