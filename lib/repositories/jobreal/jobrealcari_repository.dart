import 'package:esalesapp/apis/jobreal/jobrealcari_api.dart';
import 'package:esalesapp/models/jobreal/jobrealcari_model.dart';

class JobRealCariRepository {

	Future<List<JobRealCariModel>> getJobRealCari(String filterDoc, String searchText, int hal) async {
		JobRealCariAPI api = JobRealCariAPI();
		return await api.getJobRealCariAPI(filterDoc, searchText, hal);
	}
}
