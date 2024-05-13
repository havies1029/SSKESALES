import 'package:esalesapp/apis/mstjobcat/jobcatcari_api.dart';
import 'package:esalesapp/models/mstjobcat/jobcatcari_model.dart';

class JobCatCariRepository {

	Future<List<JobCatCariModel>> getJobCatCari(String searchText, int hal) async {
		JobCatCariAPI api = JobCatCariAPI();
		return await api.getJobCatCariAPI(searchText, hal);
	}
}
