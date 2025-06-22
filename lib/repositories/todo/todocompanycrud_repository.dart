import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/apis/todo/todocompanycrud_api.dart';
import 'package:esalesapp/models/todo/todocompanycrud_model.dart';

class TodoCompanyCrudRepository {

	TodoCompanyCrudAPI api = TodoCompanyCrudAPI();

	Future<ReturnDataAPI> todoCompanyCrudTambah(TodoCompanyCrudModel record) async {
		return await api.todoCompanyCrudTambahAPI(record);
	}
	Future<bool> todoCompanyCrudUbah(TodoCompanyCrudModel record) async {
		return await api.todoCompanyCrudUbahAPI(record);
	}
	Future<bool> todoCompanyCrudHapus(String timeline2Id) async {
		return await api.todoCompanyCrudHapusAPI(timeline2Id);
	}
	Future<TodoCompanyCrudModel> todoCompanyCrudLihat(String timeline2Id) async {
		return await api.todoCompanyCrudLihatAPI(timeline2Id);
	}
}
