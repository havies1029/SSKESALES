import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/apis/mstcustcat/custcatcrud_api.dart';
import 'package:esalesapp/models/mstcustcat/custcatcrud_model.dart';

class CustCatCrudRepository {

	CustCatCrudAPI api = CustCatCrudAPI();

	Future<ReturnDataAPI> custCatCrudTambah(CustCatCrudModel record) async {
		return await api.custCatCrudTambahAPI(record);
	}
	Future<bool> custCatCrudUbah(CustCatCrudModel record) async {
		return await api.custCatCrudUbahAPI(record);
	}
	Future<bool> custCatCrudHapus(String mcustcatId) async {
		return await api.custCatCrudHapusAPI(mcustcatId);
	}
	Future<CustCatCrudModel> custCatCrudLihat(String mcustcatId) async {
		return await api.custCatCrudLihatAPI(mcustcatId);
	}
}
