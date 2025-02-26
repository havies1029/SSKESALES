part of 'planinfo_bloc.dart';

abstract class PlanInfoEvents extends Equatable {
  const PlanInfoEvents();

  @override
  List<Object> get props => [];
}

class SetSelectedItemPlanInfoEvent extends PlanInfoEvents {
  final PlanListModel selectedItem;
  const SetSelectedItemPlanInfoEvent({required this.selectedItem});

  @override
  List<Object> get props => [selectedItem];
}