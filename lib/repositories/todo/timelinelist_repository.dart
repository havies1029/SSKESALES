import 'package:esalesapp/apis/todo/timelinelist_api.dart';
import 'package:esalesapp/models/todo/timelinelist_model.dart';

class TimelineListRepository {

	Future<List<TimelineListModel>> getTimelineList(String searchText, int hal) async {
		TimelineListAPI api = TimelineListAPI();
		return await api.getTimelineListAPI(searchText, hal);
	}
}
