import 'package:esalesapp/apis/jobreal/jobrealcari_api.dart';
import 'package:esalesapp/models/jobreal/jobrealcari_model.dart';
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';

class JobRealCariRepository {

  JobRealCariAPI api = JobRealCariAPI();

	Future<List<JobRealCariModel>> getJobRealCari(String personId, String jobCatGroupId,
    String filterDoc, String searchText, int hal) async {
		return await api.getJobRealCariAPI(personId, jobCatGroupId, 
      filterDoc, searchText, hal);
	}

  Future<ReturnDataAPI> jobRealDuplicate(String jobreal1Id) async {
		return await api.jobRealDuplicateAPI(jobreal1Id);
	}

  Future<ReturnDataAPI> jobRealMove2NextFlow(String jobreal1Id) async {
		return await api.jobRealMove2NextFlowAPI(jobreal1Id);
	}
}
