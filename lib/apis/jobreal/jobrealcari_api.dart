import 'dart:convert';
import 'package:esalesapp/common/app_data.dart';
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:esalesapp/models/jobreal/jobrealcari_model.dart';

class JobRealCariAPI {
  String urlGetListEndPoint =
      "${AppData.prefixEndPoint}/api/jobreal/jobrealcari/getlist";

  Future<List<JobRealCariModel>> getJobRealCariAPI(String personId, String filterDoc,
      String searchText, int hal) async {

    debugPrint("getJobRealCariAPI");    
    debugPrint("urlGetListEndPoint : $urlGetListEndPoint");

    Map<String, String> queryParams = {
      "personId": personId,
      "searchText": searchText,
      "filterDoc": filterDoc,
      "hal": hal.toString()
    };
    var uri = AppData.uriHtpp(AppData.httpAuthority, urlGetListEndPoint, queryParams);
    final http.Response response =
        await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/json; odata=verbos',
      'Accept': 'application/json; odata=verbos',
      'Authorization': 'Bearer ${AppData.userToken}'
    });

    //debugPrint("getJobRealCariAPI");
    //debugPrint("response.statusCode : ${response.statusCode}");
    //debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<JobRealCariModel>((json) => JobRealCariModel.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<ReturnDataAPI> jobRealDuplicateAPI(String jobreal1Id) async {
		String duplicateEndpoint = "${AppData.prefixEndPoint}/api/jobreal/jobrealcrud/duplicate";
		Map<String, String> queryParams = {
			'jobreal1Id': jobreal1Id,
			'modul_id': 'jobRealDuplicateAPI'};
		var uri = AppData.uriHtpp(AppData.httpAuthority, duplicateEndpoint, queryParams);
		final http.Response response =
			await http.get(uri, headers: <String, String>{
			'Content-Type': 'application/json; odata=verbos',
			'Accept': 'application/json; odata=verbos',
			'Authorization': 'Bearer ${AppData.userToken}'
		});

		ReturnDataAPI returnData;
		if (response.statusCode == 200) {
			returnData = ReturnDataAPI.fromDatabaseJson(jsonDecode(response.body));
		} else {
			returnData = ReturnDataAPI(success: false, data: "", rowcount: 0);
		}
		return returnData;
	}
}
