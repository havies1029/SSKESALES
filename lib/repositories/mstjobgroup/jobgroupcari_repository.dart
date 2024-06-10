import 'package:esalesapp/apis/mstjobgroup/jobgroupcari_api.dart';
import 'package:esalesapp/models/mstjobgroup/jobgroupcari_model.dart';

class JobGroupCariRepository {

	Future<List<JobGroupCariModel>> getJobGroupCari(String searchText, int hal) async {
		JobGroupCariAPI api = JobGroupCariAPI();
		return await api.getJobGroupCariAPI(searchText, hal);
	}
}
