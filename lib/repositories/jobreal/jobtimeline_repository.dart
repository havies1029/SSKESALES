import 'package:esalesapp/apis/jobreal/jobtimeline_api.dart';
import 'package:esalesapp/models/jobreal/jobtimeline_model.dart';
import 'package:flutter/material.dart';

class JobtimelineRepository {
  Future<List<JobtimelineModel>> getJobtimelineBySppa(
      String jobRealId, String polisId, int hal) async {
    JobtimelineAPI api = JobtimelineAPI();
    return await api.getJobtimelineBySppaAPI(jobRealId, polisId, hal);
  }

  Future<List<JobtimelineModel>> getJobtimelineNonSppa(
      String jobRealId, int hal) async {
    debugPrint("JobtimelineRepository -> getJobtimelineNonSppa");
    JobtimelineAPI api = JobtimelineAPI();
    return await api.getJobtimelineNonSppaAPI(jobRealId, hal);
  }
}
