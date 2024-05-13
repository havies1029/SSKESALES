import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/apis/mstjabatan/jabatancrud_api.dart';
import 'package:esalesapp/models/mstjabatan/jabatancrud_model.dart';

class JabatanCrudRepository {

	JabatanCrudAPI api = JabatanCrudAPI();

	Future<ReturnDataAPI> jabatanCrudTambah(JabatanCrudModel record) async {
		return await api.jabatanCrudTambahAPI(record);
	}
	Future<bool> jabatanCrudUbah(JabatanCrudModel record) async {
		return await api.jabatanCrudUbahAPI(record);
	}
	Future<bool> jabatanCrudHapus(String mjabatanId) async {
		return await api.jabatanCrudHapusAPI(mjabatanId);
	}
	Future<JabatanCrudModel> jabatanCrudLihat(String mjabatanId) async {
		return await api.jabatanCrudLihatAPI(mjabatanId);
	}
}
