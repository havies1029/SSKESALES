import 'package:esalesapp/apis/mstmedia/mediacari_api.dart';
import 'package:esalesapp/models/mstmedia/mediacari_model.dart';

class MediaCariRepository {

	Future<List<MediaCariModel>> getMediaCari(String searchText, int hal) async {
		MediaCariAPI api = MediaCariAPI();
		return await api.getMediaCariAPI(searchText, hal);
	}
}
