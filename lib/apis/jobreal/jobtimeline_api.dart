import 'dart:convert';
import 'package:esalesapp/common/app_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:esalesapp/models/jobreal/jobtimeline_model.dart';

class JobtimelineAPI {
  Future<List<JobtimelineModel>> getJobtimelineBySppaAPI(
      String jobRealId, String polisId, int hal) async {
    String urlGetListEndPoint =
        "${AppData.prefixEndPoint}/api/jobreal/joblist/getlist/bysppa";

    Map<String, String> queryParams = {
      "jobReal1Id": jobRealId,
      "polisId": polisId,
      "hal": hal.toString()
    };
    var uri = Uri.http(AppData.httpAuthority, urlGetListEndPoint, queryParams);
    final http.Response response =
        await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/json; odata=verbos',
      'Accept': 'application/json; odata=verbos',
      'Authorization': 'Bearer ${AppData.userToken}'
    });

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<JobtimelineModel>((json) => JobtimelineModel.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<List<JobtimelineModel>> getJobtimelineNonSppaAPI(
      String jobRealId, int hal) async {
    debugPrint("JobtimelineAPI -> getJobtimelineNonSppaAPI");

    String urlGetListEndPoint =
        "${AppData.prefixEndPoint}/api/jobreal/joblist/getlist/nonsppa";

    Map<String, String> queryParams = {
      "jobReal1Id": jobRealId,
      "hal": hal.toString()
    };


    //debugPrint("AppData.userToken : ${AppData.userToken}");  
    //debugPrint("urlGetListEndPoint : $urlGetListEndPoint");   

    var uri = Uri.http(AppData.httpAuthority, urlGetListEndPoint, queryParams);
    final http.Response response =
        await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/json; odata=verbos',
      'Accept': 'application/json; odata=verbos',
      'Authorization': 'Bearer ${AppData.userToken}'
    });
    
    debugPrint("response.statusCode : ${response.statusCode}");    

    if (response.statusCode == 200) {
      debugPrint("response.body : ${response.body}");

      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<JobtimelineModel>((json) => JobtimelineModel.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to load data");
    }
  }
}
