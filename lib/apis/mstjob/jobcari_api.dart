import 'dart:convert';
import 'package:esalesapp/common/app_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:esalesapp/models/mstjob/jobcari_model.dart';

class JobCariAPI {
  String urlGetListEndPoint =
      "${AppData.prefixEndPoint}/api/mstjob/jobcari/getlist";

  Future<List<JobCariModel>> getJobCariAPI(
      String personId, String searchText, int hal) async {
    debugPrint("getJobCariAPI personId : $personId");
    Map<String, String> queryParams = {
      "personId": personId,
      "searchText": searchText,
      "hal": hal.toString()
    };
    var uri = AppData.uriHtpp(AppData.httpAuthority, urlGetListEndPoint, queryParams);
    final http.Response response =
        await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/json; odata=verbos',
      'Accept': 'application/json; odata=verbos',
      'Authorization': 'Bearer ${AppData.userToken}'
    });

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<JobCariModel>((json) => JobCariModel.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to load data");
    }
  }
}
