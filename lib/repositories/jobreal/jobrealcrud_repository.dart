import 'package:esalesapp/apis/jobreal/newbriefinginitvalue_api.dart';
import 'package:esalesapp/models/jobreal/newbriefinginitvalue_model.dart';
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:esalesapp/apis/jobreal/jobrealcrud_api.dart';
import 'package:esalesapp/models/jobreal/jobrealcrud_model.dart';
import 'package:esalesapp/models/soaclient/tasksoainit_model.dart';
import 'package:esalesapp/repositories/soaclient/tasksoainit_repository.dart';

class JobRealCrudRepository {
  JobRealCrudAPI api = JobRealCrudAPI();

  Future<ReturnDataAPI> jobRealCrudTambah(JobRealCrudModel record) async {
    return await api.jobRealCrudTambahAPI(record);
  }

  Future<bool> jobRealCrudUbah(JobRealCrudModel record) async {
    return await api.jobRealCrudUbahAPI(record);
  }

  Future<bool> jobRealCrudHapus(String jobreal1Id) async {
    return await api.jobRealCrudHapusAPI(jobreal1Id);
  }

  Future<JobRealCrudModel> jobRealCrudLihat(String jobreal1Id) async {
    return await api.jobRealCrudLihatAPI(jobreal1Id);
  }

  Future<ReturnDataAPI> jobRealOtorisasi(String jobreal1Id) async {
    return await api.jobRealOtorisasiAPI(jobreal1Id);
  }

  Future<NewBriefingInitValueModel> jobRealGetNewBriefingInitValue(
      String jobId, String jobCatId) async {
    NewbriefinginitvalueAPI initValueApi = NewbriefinginitvalueAPI();
    return await initValueApi.getNewbriefinginitvalueAPI(jobId, jobCatId);
  }

  Future<TasksoainitModel> jobRealGetNewSoaClientInitValue(String dn1Id) async {
    
    TasksoainitRepository tasksoainitRepository = TasksoainitRepository();
    return await tasksoainitRepository.getTasksoainit(dn1Id);
  }
}
