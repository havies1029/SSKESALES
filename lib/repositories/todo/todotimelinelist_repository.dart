import 'package:esalesapp/apis/todo/todotimelinelist_api.dart';
import 'package:esalesapp/models/todo/todotimelinelist_model.dart';
import 'package:infinite_calendar_view/infinite_calendar_view.dart';

class TodoTimelineListRepository {
  Future<List<TodoTimelineListModel>> getTodoTimelineList(
      DateTime tgl1, DateTime tgl2, String calendarView) async {
    TodoTimelineListAPI api = TodoTimelineListAPI();
    return await api.getTodoTimelineListAPI(tgl1, calendarView);
  }

  Future<List<Event>> getTodoList(DateTime tgl1, String calendarView) async {
    TodoTimelineListAPI api = TodoTimelineListAPI();
    var listTimeline1 = await api.getTodoTimelineListAPI(tgl1, calendarView);
    List<Event> listEvent = listTimeline1.map((item) {
      return Event(
          title: item.groupNama,
          description: item.aktivitas,
          startTime: item.jamMulai,
          endTime: item.jamAkhir,
          data: item.timeline1Id);
    }).toList();

    return listEvent;
  }
}
