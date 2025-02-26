import 'dart:convert';
import 'package:esalesapp/common/app_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:esalesapp/models/projectplan/planlist_model.dart';

class PlanListAPI {
  Future<List<PlanListModel>> getPlanListAPI(String projectId, int hal) async {
    String urlGetListEndPoint =
        "${AppData.prefixEndPoint}/api/projectplan/planlist/getlist";

    Map<String, String> queryParams = {
      "projectId": projectId,
      "hal": hal.toString()
    };
    var uri =
        AppData.uriHtpp(AppData.httpAuthority, urlGetListEndPoint, queryParams);
    final http.Response response =
        await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/json; odata=verbos',
      'Accept': 'application/json; odata=verbos',
      'Authorization': 'Bearer ${AppData.userToken}'
    });

    if (response.statusCode == 200) {
      //debugPrint("getPlanListAPI -> json.decode(response.body) : ${json.decode(response.body)}");
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<PlanListModel>((json) => PlanListModel.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to load data");
    }
  }
}
