part of 'expiredbysales_bloc.dart';

abstract class ExpiredBySalesEvents extends Equatable {
  const ExpiredBySalesEvents();

  @override
  List<Object> get props => [];
}

class FetchExpiredBySalesEvent extends ExpiredBySalesEvents {
  final String expgroupId;

  const FetchExpiredBySalesEvent({required this.expgroupId});

  @override
  List<Object> get props => [expgroupId];
}

class RefreshExpiredBySalesEvent extends ExpiredBySalesEvents {
    final String expgroupId;

  const RefreshExpiredBySalesEvent({required this.expgroupId});

  @override
  List<Object> get props => [expgroupId];
}
