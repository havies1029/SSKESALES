import 'package:esalesapp/apis/timeline/expiredbysales_api.dart';
import 'package:esalesapp/models/timeline/expiredbysales_model.dart';

class ExpiredBySalesRepository {

	Future<List<ExpiredBySalesModel>> getExpiredBySales(String expgroupId) async {
		ExpiredBySalesAPI api = ExpiredBySalesAPI();
		return await api.getExpiredBySalesAPI(expgroupId);
	}
}
