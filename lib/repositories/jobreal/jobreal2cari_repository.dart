import 'package:esalesapp/apis/jobreal/jobreal2cari_api.dart';
import 'package:esalesapp/models/jobreal/jobreal2cari_model.dart';

class JobReal2CariRepository {

	Future<List<JobReal2CariModel>> getJobReal2Cari(String custId, String? jobcatId,
    String? jobreal1Id) async {
		JobReal2CariAPI api = JobReal2CariAPI();
		return await api.getJobReal2CariAPI(custId, jobcatId, jobreal1Id);
	}

  Future<List<JobReal2CariModel>> getJobReal2List(String jobreal1Id) async {
		JobReal2CariAPI api = JobReal2CariAPI();
		return await api.getJobReal2ListAPI(jobreal1Id);
	}
}
