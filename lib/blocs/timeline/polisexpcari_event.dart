part of 'polisexpcari_bloc.dart';

abstract class PolisExpCariEvents extends Equatable {
  const PolisExpCariEvents();

  @override
  List<Object> get props => [];
}

class FetchPolisExpCariEvent extends PolisExpCariEvents {
  final String expgroupId;
  final String personalId;  
	final String searchText;
  const FetchPolisExpCariEvent({required this.expgroupId, required this.personalId,
    required this.searchText});
  
  @override
  List<Object> get props => [expgroupId, personalId, searchText];
}

class RefreshPolisExpCariEvent extends PolisExpCariEvents {
  final String expgroupId;
  final String personalId;  
	final String searchText;
  const RefreshPolisExpCariEvent(
    {required this.expgroupId, required this.personalId,
      required this.searchText});
  
  @override
  List<Object> get props => [expgroupId, personalId, searchText];
}
