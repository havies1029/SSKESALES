part of 'briefinginfo_bloc.dart';

abstract class BriefingInfoEvents extends Equatable {
  const BriefingInfoEvents();

  @override
  List<Object> get props => [];
}

class SetSelectedItemBriefingInfoEvent extends BriefingInfoEvents {
  final BriefinglistModel selectedItem;
  const SetSelectedItemBriefingInfoEvent({required this.selectedItem});

  @override
  List<Object> get props => [selectedItem];
}

class CekStatusBriefingHariIniEvent extends BriefingInfoEvents{}