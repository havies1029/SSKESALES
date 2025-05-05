part of 'prjtree_bloc.dart';

abstract class PrjTreeEvent extends Equatable {
  const PrjTreeEvent();

  @override
  List<Object> get props => [];
}

class FetchTreeData extends PrjTreeEvent {}

