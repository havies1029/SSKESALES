part of 'planinfo_bloc.dart';

class PlanInfoState extends Equatable {
  final PlanListModel selectedItem;

  const PlanInfoState({
    this.selectedItem = const PlanListModel()});

  PlanInfoState copyWith(
      {PlanListModel? selectedItem}) {
    return PlanInfoState(
        selectedItem: selectedItem ?? this.selectedItem);
  }

  
  @override
  List<Object> get props => [selectedItem];

}
