import 'package:esalesapp/apis/calendar/eventrenewcari_api.dart';
import 'package:esalesapp/models/calendar/event_renewal_model.dart';

class EventRenewCariRepository {
  Future<List<EventRenewalModel>> getEventRenewalCari() async {
    EventRenewalCariAPI api = EventRenewalCariAPI();
    return await api.getEventRenewalCariAPI();
  }
}
