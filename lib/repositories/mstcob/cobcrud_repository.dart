import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/apis/mstcob/cobcrud_api.dart';
import 'package:esalesapp/models/mstcob/cobcrud_model.dart';

class CobCrudRepository {

	CobCrudAPI api = CobCrudAPI();

	Future<ReturnDataAPI> cobCrudTambah(CobCrudModel record) async {
		return await api.cobCrudTambahAPI(record);
	}
	Future<bool> cobCrudUbah(CobCrudModel record) async {
		return await api.cobCrudUbahAPI(record);
	}
	Future<bool> cobCrudHapus(String mcobId) async {
		return await api.cobCrudHapusAPI(mcobId);
	}
	Future<CobCrudModel> cobCrudLihat(String mcobId) async {
		return await api.cobCrudLihatAPI(mcobId);
	}
}
