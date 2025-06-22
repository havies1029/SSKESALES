import 'package:esalesapp/apis/todo/todocompanylist_api.dart';
import 'package:esalesapp/models/todo/todocompanylist_model.dart';

class TodoCompanyListRepository {

	Future<List<TodoCompanyListModel>> getTodoCompanyList(String timeline1Id, int hal) async {
		TodoCompanyListAPI api = TodoCompanyListAPI();
		return await api.getTodoCompanyListAPI(timeline1Id, hal);
	}
}
