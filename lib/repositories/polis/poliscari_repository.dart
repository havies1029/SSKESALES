import 'package:esalesapp/apis/polis/poliscari_api.dart';
import 'package:esalesapp/models/polis/poliscari_model.dart';

class PolisCariRepository {

	Future<List<PolisCariModel>> getPolisCari(String searchText, int hal) async {
		PolisCariAPI api = PolisCariAPI();
		return await api.getPolisCariAPI(searchText, hal);
	}
}
