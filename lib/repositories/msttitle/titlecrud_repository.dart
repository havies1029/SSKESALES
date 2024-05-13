import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/apis/msttitle/titlecrud_api.dart';
import 'package:esalesapp/models/msttitle/titlecrud_model.dart';

class TitleCrudRepository {

	TitleCrudAPI api = TitleCrudAPI();

	Future<ReturnDataAPI> titleCrudTambah(TitleCrudModel record) async {
		return await api.titleCrudTambahAPI(record);
	}
	Future<bool> titleCrudUbah(TitleCrudModel record) async {
		return await api.titleCrudUbahAPI(record);
	}
	Future<bool> titleCrudHapus(String mtitleId) async {
		return await api.titleCrudHapusAPI(mtitleId);
	}
	Future<TitleCrudModel> titleCrudLihat(String mtitleId) async {
		return await api.titleCrudLihatAPI(mtitleId);
	}
}
