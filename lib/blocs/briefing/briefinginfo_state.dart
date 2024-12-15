part of 'briefinginfo_bloc.dart';

class BriefingInfoState extends Equatable {
  final BriefinglistModel selectedItem;
  final bool hasPassedBriefing;

  const BriefingInfoState({
    this.selectedItem = const BriefinglistModel(), 
    this.hasPassedBriefing = false});

  BriefingInfoState copyWith(
      {BriefinglistModel? selectedItem, bool? hasPassedBriefing}) {
    return BriefingInfoState(
        selectedItem: selectedItem ?? this.selectedItem,
        hasPassedBriefing: hasPassedBriefing ?? this.hasPassedBriefing);
  }

  
  @override
  List<Object> get props => [selectedItem, hasPassedBriefing];

}
