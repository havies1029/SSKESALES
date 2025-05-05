import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/apis/projecttree/treenodecrud_api.dart';
import 'package:esalesapp/models/projecttree/treenodecrud_model.dart';

class TreenodeCrudRepository {

	TreenodeCrudAPI api = TreenodeCrudAPI();

	Future<ReturnDataAPI> treenodeCrudTambah(TreenodeCrudModel record) async {
		return await api.treenodeCrudTambahAPI(record);
	}
	Future<bool> treenodeCrudUbah(TreenodeCrudModel record) async {
		return await api.treenodeCrudUbahAPI(record);
	}
	Future<bool> treenodeCrudHapus(String prjtree2Id) async {
		return await api.treenodeCrudHapusAPI(prjtree2Id);
	}
	Future<TreenodeCrudModel> treenodeCrudLihat(String prjtree2Id) async {
		return await api.treenodeCrudLihatAPI(prjtree2Id);
	}
}
