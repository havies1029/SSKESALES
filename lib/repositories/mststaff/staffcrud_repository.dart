import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/apis/mststaff/staffcrud_api.dart';
import 'package:esalesapp/models/mststaff/staffcrud_model.dart';

class StaffCrudRepository {

	StaffCrudAPI api = StaffCrudAPI();

	Future<ReturnDataAPI> staffCrudTambah(StaffCrudModel record) async {
		return await api.staffCrudTambahAPI(record);
	}
	Future<bool> staffCrudUbah(StaffCrudModel record) async {
		return await api.staffCrudUbahAPI(record);
	}
	Future<bool> staffCrudHapus(String mstaffId) async {
		return await api.staffCrudHapusAPI(mstaffId);
	}
	Future<StaffCrudModel> staffCrudLihat(String mstaffId) async {
		return await api.staffCrudLihatAPI(mstaffId);
	}
}
