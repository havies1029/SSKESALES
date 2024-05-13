import 'package:esalesapp/apis/mstjob/jobcari_api.dart';
import 'package:esalesapp/models/mstjob/jobcari_model.dart';

class JobCariRepository {

	Future<List<JobCariModel>> getJobCari(String searchText, int hal) async {
		JobCariAPI api = JobCariAPI();
		return await api.getJobCariAPI(searchText, hal);
	}
}
