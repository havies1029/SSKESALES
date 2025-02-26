import 'package:esalesapp/apis/projectplan/planlist_api.dart';
import 'package:esalesapp/models/projectplan/planlist_model.dart';

class PlanListRepository {

	Future<List<PlanListModel>> getPlanList(String projectId, int hal) async {
		PlanListAPI api = PlanListAPI();
		return await api.getPlanListAPI(projectId, hal);
	}
}
