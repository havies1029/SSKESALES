part of 'planlist_bloc.dart';

abstract class PlanListEvents extends Equatable {
	const PlanListEvents();

	@override
	List<Object> get props => [];
}

class FetchPlanListEvent extends PlanListEvents {}

class RefreshPlanListEvent extends PlanListEvents {	
	final String projectId;

	const RefreshPlanListEvent({required this.projectId});

	@override
	List<Object> get props => [projectId];
}

class UbahPlanListEvent extends PlanListEvents {
	final String recordId;

	const UbahPlanListEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class TambahPlanListEvent extends PlanListEvents{}
class HapusPlanListEvent extends PlanListEvents{}
class CloseDialogPlanListEvent extends PlanListEvents{}
