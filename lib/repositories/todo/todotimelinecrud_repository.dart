import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/apis/todo/todotimelinecrud_api.dart';
import 'package:esalesapp/models/todo/todotimelinecrud_model.dart';

class TodoTimelineCrudRepository {

	TodoTimelineCrudAPI api = TodoTimelineCrudAPI();

	Future<ReturnDataAPI> todoTimelineCrudTambah(TodoTimelineCrudModel record) async {
		return await api.todoTimelineCrudTambahAPI(record);
	}
	Future<bool> todoTimelineCrudUbah(TodoTimelineCrudModel record) async {
		return await api.todoTimelineCrudUbahAPI(record);
	}
	Future<bool> todoTimelineCrudHapus(String timeline1Id) async {
		return await api.todoTimelineCrudHapusAPI(timeline1Id);
	}
	Future<TodoTimelineCrudModel> todoTimelineCrudLihat(String timeline1Id) async {
		return await api.todoTimelineCrudLihatAPI(timeline1Id);
	}
}
