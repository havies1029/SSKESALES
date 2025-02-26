import 'package:equatable/equatable.dart';
import 'package:esalesapp/models/projectplan/planlist_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'planinfo_event.dart';
part 'planinfo_state.dart';

class PlanInfoBloc extends Bloc<PlanInfoEvents, PlanInfoState> {
  PlanInfoBloc() : super(const PlanInfoState()) {
    on<SetSelectedItemPlanInfoEvent>(onSetSelectedItemPlanList);
  }

  Future<void> onSetSelectedItemPlanList(
      SetSelectedItemPlanInfoEvent event,
      Emitter<PlanInfoState> emit) async {
    //debugPrint("event.selectedItem : ${jsonEncode(event.selectedItem)}");

    emit(state.copyWith(selectedItem: event.selectedItem));

    //debugPrint("state.selectedItem : ${jsonEncode(state.selectedItem)}");
  }
}