import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/apis/mstmedia/mediacrud_api.dart';
import 'package:esalesapp/models/mstmedia/mediacrud_model.dart';

class MediaCrudRepository {

	MediaCrudAPI api = MediaCrudAPI();

	Future<ReturnDataAPI> mediaCrudTambah(MediaCrudModel record) async {
		return await api.mediaCrudTambahAPI(record);
	}
	Future<bool> mediaCrudUbah(MediaCrudModel record) async {
		return await api.mediaCrudUbahAPI(record);
	}
	Future<bool> mediaCrudHapus(String mmediaId) async {
		return await api.mediaCrudHapusAPI(mmediaId);
	}
	Future<MediaCrudModel> mediaCrudLihat(String mmediaId) async {
		return await api.mediaCrudLihatAPI(mmediaId);
	}
}
