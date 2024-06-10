import 'package:equatable/equatable.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/models/calendar/event_renewal_model.dart';
import 'package:esalesapp/repositories/calendar/eventrenewcari_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'eventrenewalcari_event.dart';
part 'eventrenewalcari_state.dart';

class EventRenewalCariBloc
    extends Bloc<EventRenewalCariEvents, EventRenewalCariState> {
  EventRenewalCariBloc() : super(const EventRenewalCariState()) {
    on<RefreshEventRenewalCariEvent>(onRefreshEventRenewalCari);
  }

  Future<void> onRefreshEventRenewalCari(RefreshEventRenewalCariEvent event,
      Emitter<EventRenewalCariState> emit) async {
    emit(const EventRenewalCariState());

    EventRenewCariRepository repo = EventRenewCariRepository();
    if (state.status == ListStatus.initial) {
      if (!state.hasReachedMax) {
        List<EventRenewalModel> items = await repo.getEventRenewalCari();
        return emit(state.copyWith(
            items: items, status: ListStatus.success, hasReachedMax: true));
      }
    }
  }
}
