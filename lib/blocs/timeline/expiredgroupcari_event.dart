part of 'expiredgroupcari_bloc.dart';

abstract class ExpiredGroupCariEvents extends Equatable {
	const ExpiredGroupCariEvents();

	@override
	List<Object> get props => [];
}

class FetchExpiredGroupCariEvent extends ExpiredGroupCariEvents {}

class RefreshExpiredGroupCariEvent extends ExpiredGroupCariEvents {}

