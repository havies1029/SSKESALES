import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/apis/projecttree/prjtreecrud_api.dart';
import 'package:esalesapp/models/projecttree/prjtreecrud_model.dart';

class PrjtreeCrudRepository {

	PrjtreeCrudAPI api = PrjtreeCrudAPI();

	Future<ReturnDataAPI> prjtreeCrudTambah(PrjtreeCrudModel record) async {
		return await api.prjtreeCrudTambahAPI(record);
	}
	Future<bool> prjtreeCrudUbah(PrjtreeCrudModel record) async {
		return await api.prjtreeCrudUbahAPI(record);
	}
	Future<bool> prjtreeCrudHapus(String prjtree1Id) async {
		return await api.prjtreeCrudHapusAPI(prjtree1Id);
	}
	Future<PrjtreeCrudModel> prjtreeCrudLihat(String prjtree1Id) async {
		return await api.prjtreeCrudLihatAPI(prjtree1Id);
	}
}
