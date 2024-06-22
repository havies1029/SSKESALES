import 'package:esalesapp/apis/timeline/expiredgroupcari_api.dart';
import 'package:esalesapp/models/timeline/expiredgroupcari_model.dart';

class ExpiredGroupCariRepository {

	Future<List<ExpiredGroupCariModel>> getExpiredGroupCari() async {
		ExpiredGroupCariAPI api = ExpiredGroupCariAPI();
		return await api.getExpiredGroupCariAPI();
	}
}
