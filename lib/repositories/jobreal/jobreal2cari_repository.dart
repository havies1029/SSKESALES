import 'package:esalesapp/apis/jobreal/jobreal2cari_api.dart';
import 'package:esalesapp/models/jobreal/jobreal2cari_model.dart';
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';

class JobReal2CariRepository {
  Future<List<JobReal2CariModel>> getJobReal2Cari(
      String custId, String? jobreal1Id, String? searchText, int hal) async {
    JobReal2CariAPI api = JobReal2CariAPI();
    return await api.getJobReal2CariAPI(custId, jobreal1Id, searchText, hal);
  }

  Future<List<JobReal2CariModel>> getJobReal2Grid(String jobreal1Id, int hal) async {
    JobReal2CariAPI api = JobReal2CariAPI();
    return await api.getJobReal2GridAPI(jobreal1Id, hal);
  }

  Future<ReturnDataAPI> jobReal2UpdateList(
      String jobreal1Id, List<JobReal2CariCheckboxModel> listChecked) async {
    JobReal2CariAPI api = JobReal2CariAPI();
    return api.jobReal2UpdateListAPI(jobreal1Id, listChecked);
  }

  Future<ReturnDataAPI> jobReal2DeleteAll(String jobreal1Id) async {    
    JobReal2CariAPI api = JobReal2CariAPI();
    return api.deleteAllJobReal2GridAPI(jobreal1Id);
  }

  Future<ReturnDataAPI> jobReal2Tambah(String jobreal1Id, String polis1Id) async {    
    JobReal2CariAPI api = JobReal2CariAPI();
    return api.jobReal2TambahAPI(jobreal1Id, polis1Id);
  }
}
