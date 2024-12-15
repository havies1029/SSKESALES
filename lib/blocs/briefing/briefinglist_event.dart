part of 'briefinglist_bloc.dart';

abstract class BriefinglistEvents extends Equatable {
  const BriefinglistEvents();

  @override
  List<Object> get props => [];
}

class FetchBriefinglistEvent extends BriefinglistEvents {}

class RefreshBriefinglistEvent extends BriefinglistEvents {}

class GetJobCatGroupOtherRecordEvent extends BriefinglistEvents {}

/*
class SetSelectedItemBriefingListEvent extends BriefinglistEvents {
  final BriefinglistModel selectedItem;
  final int selectedIndex;
  const SetSelectedItemBriefingListEvent({required this.selectedItem, required this.selectedIndex});

  @override
  List<Object> get props => [selectedItem, selectedIndex];
}

class CekStatusBriefingHariIniEvent extends BriefinglistEvents{}
*/