part of 'clientassigncari_bloc.dart';

abstract class ClientAssignCariEvents extends Equatable {
	const ClientAssignCariEvents();

	@override
	List<Object> get props => [];
}

class FetchClientAssignCariEvent extends ClientAssignCariEvents {}

class RefreshClientAssignCariEvent extends ClientAssignCariEvents {}

