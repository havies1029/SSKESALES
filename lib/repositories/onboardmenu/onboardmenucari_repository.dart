
import 'package:esalesapp/apis/onboardmenu/onboardmenucari_api.dart';
import 'package:esalesapp/models/onboardmenu/onboardmenucari_model.dart';

class OnBoardMenuCariRepository {

	Future<OnBoardMenuCariModel> getOnBoardMenuCari() async {
		OnBoardMenuCariAPI api = OnBoardMenuCariAPI();
		return await api.getOnBoardMenuCariAPI();
	}
}
