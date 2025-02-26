import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/apis/projectplan/plancrud_api.dart';
import 'package:esalesapp/models/projectplan/plancrud_model.dart';

class PlanCrudRepository {

	PlanCrudAPI api = PlanCrudAPI();

	Future<ReturnDataAPI> planCrudTambah(PlanCrudModel record) async {
		return await api.planCrudTambahAPI(record);
	}
	Future<bool> planCrudUbah(PlanCrudModel record) async {
		return await api.planCrudUbahAPI(record);
	}
	Future<bool> planCrudHapus(String plan1Id) async {
		return await api.planCrudHapusAPI(plan1Id);
	}
	Future<PlanCrudModel> planCrudLihat(String plan1Id) async {
		return await api.planCrudLihatAPI(plan1Id);
	}
}
