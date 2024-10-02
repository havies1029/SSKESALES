import 'package:esalesapp/apis/jobreal/sppacari_api.dart';
import 'package:esalesapp/models/jobreal/sppacari_model.dart';

class SppaCariRepository {

	Future<List<SppaCariModel>> getSppaCari(String jobRealId, String searchText, int hal) async {
		SppaCariAPI api = SppaCariAPI();
		return await api.getSppaCariAPI(jobRealId, searchText, hal);
	}
}
