import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/apis/mstrekan/rekancontactcrud_api.dart';
import 'package:esalesapp/models/mstrekan/rekancontactcrud_model.dart';

class RekanContactCrudRepository {

	RekanContactCrudAPI api = RekanContactCrudAPI();

	Future<ReturnDataAPI> rekanContactCrudTambah(RekanContactCrudModel record) async {
		return await api.rekanContactCrudTambahAPI(record);
	}
	Future<bool> rekanContactCrudUbah(RekanContactCrudModel record) async {
		return await api.rekanContactCrudUbahAPI(record);
	}
	Future<bool> rekanContactCrudHapus(String mcontactId) async {
		return await api.rekanContactCrudHapusAPI(mcontactId);
	}
	Future<RekanContactCrudModel> rekanContactCrudLihat(String mcontactId) async {
		return await api.rekanContactCrudLihatAPI(mcontactId);
	}
}
