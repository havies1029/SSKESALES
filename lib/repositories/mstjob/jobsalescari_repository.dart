import 'package:esalesapp/apis/mstjob/jobsalescari_api.dart';
import 'package:esalesapp/models/mstjob/jobsalescari_model.dart';

class JobSalesCariRepository {

	Future<List<JobSalesCariModel>> getJobSalesCari(String searchText, int hal) async {
		JobSalesCariAPI api = JobSalesCariAPI();
		return await api.getJobSalesCariAPI(searchText, hal);
	}
}
