import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/apis/todo/companycrud_api.dart';
import 'package:esalesapp/models/todo/companycrud_model.dart';

class CompanyCrudRepository {

	CompanyCrudAPI api = CompanyCrudAPI();

	Future<ReturnDataAPI> companyCrudTambah(CompanyCrudModel record) async {
		return await api.companyCrudTambahAPI(record);
	}
	Future<bool> companyCrudUbah(CompanyCrudModel record) async {
		return await api.companyCrudUbahAPI(record);
	}
	Future<bool> companyCrudHapus(String timeline2Id) async {
		return await api.companyCrudHapusAPI(timeline2Id);
	}
	Future<CompanyCrudModel> companyCrudLihat(String timeline2Id) async {
		return await api.companyCrudLihatAPI(timeline2Id);
	}
}
