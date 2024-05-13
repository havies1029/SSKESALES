import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/apis/polis/poliscrud_api.dart';
import 'package:esalesapp/models/polis/poliscrud_model.dart';

class PolisCrudRepository {

	PolisCrudAPI api = PolisCrudAPI();

	Future<ReturnDataAPI> polisCrudTambah(PolisCrudModel record) async {
		return await api.polisCrudTambahAPI(record);
	}
	Future<bool> polisCrudUbah(PolisCrudModel record) async {
		return await api.polisCrudUbahAPI(record);
	}
	Future<bool> polisCrudHapus(String polis1Id) async {
		return await api.polisCrudHapusAPI(polis1Id);
	}
	Future<PolisCrudModel> polisCrudLihat(String polis1Id) async {
		return await api.polisCrudLihatAPI(polis1Id);
	}
}
