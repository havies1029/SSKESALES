import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/apis/todo/timelinecrud_api.dart';
import 'package:esalesapp/models/todo/timelinecrud_model.dart';

class TimelineCrudRepository {

	TimelineCrudAPI api = TimelineCrudAPI();

	Future<ReturnDataAPI> timelineCrudTambah(TimelineCrudModel record) async {
		return await api.timelineCrudTambahAPI(record);
	}
	Future<bool> timelineCrudUbah(TimelineCrudModel record) async {
		return await api.timelineCrudUbahAPI(record);
	}
	Future<bool> timelineCrudHapus(String timeline1Id) async {
		return await api.timelineCrudHapusAPI(timeline1Id);
	}
	Future<TimelineCrudModel> timelineCrudLihat(String timeline1Id) async {
		return await api.timelineCrudLihatAPI(timeline1Id);
	}
}
