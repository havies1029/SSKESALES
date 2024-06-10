import 'dart:convert';
import 'package:esalesapp/common/app_data.dart';
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:esalesapp/models/jobreal/jobreal3cari_model.dart';

class JobReal3CariAPI{
	Future<List<JobReal3CariModel>> getJobReal3CariAPI(
      String jobreal1Id, String searchText, int hal) async {
		String urlGetListEndPoint = "${AppData.prefixEndPoint}/api/jobreal/jobreal3cari/getlist";
    Map<String, String> queryParams = {
      "jobreal1Id": jobreal1Id,
      "searchText": searchText,
      "hal": hal.toString()
    };
		var uri = Uri.http(AppData.httpAuthority, urlGetListEndPoint, queryParams);
		final http.Response response = await http.get(uri, headers: <String, String>{
			'Content-Type': 'application/json; odata=verbos',
			'Accept': 'application/json; odata=verbos',
			'Authorization': 'Bearer ${AppData.userToken}'
		});

		if (response.statusCode == 200) {
			final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
			return parsed
				.map<JobReal3CariModel>((json) => JobReal3CariModel.fromJson(json))
				.toList();
		} else {
			throw Exception("Failed to load data");
		}
	}

  Future<ReturnDataAPI> jobReal3UpdateListAPI(String jobreal1Id, 
    List<JobReal3CariCheckboxModel> listChecked) async {
		String updateListEndpoint =
			"${AppData.prefixEndPoint}/api/jobreal/jobreal3crud/updatelistchecked";
		Map<String, String> queryParams = {
      "jobreal1Id": jobreal1Id,
      "modul_id": "jobReal2UpdateListAPI"};
		var uri = AppData.uriHtpp(AppData.httpAuthority, updateListEndpoint, queryParams);

		ReturnDataAPI returnData;
		final http.Response response = await http.post(uri,
			headers: <String, String>{
				'Content-Type': 'application/json; odata=verbos',
				'Accept': 'application/json; odata=verbos',
				'Authorization': 'Bearer ${AppData.userToken}'
			},
			body: jsonEncode(listChecked));

		if (response.statusCode == 200) {
			returnData = ReturnDataAPI.fromDatabaseJson(jsonDecode(response.body));
		} else {
			returnData = ReturnDataAPI(success: false, data: "", rowcount: 0);
		}
		return returnData;
	}

  Future<List<JobReal3CariModel>> getJobReal3GridAPI(String jobreal1Id) async {

    String urlGetListEndPoint =
      "${AppData.prefixEndPoint}/api/jobreal/jobreal3crud/getlist";

    Map<String, String> queryParams = {      
      "jobreal1Id": jobreal1Id
    };
    var uri = Uri.http(AppData.httpAuthority, urlGetListEndPoint, queryParams);
    final http.Response response =
        await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/json; odata=verbos',
      'Accept': 'application/json; odata=verbos',
      'Authorization': 'Bearer ${AppData.userToken}'
    });

    debugPrint("getJobReal3GridAPI");
    debugPrint("response.statusCode : ${response.statusCode}");
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<JobReal3CariModel>((json) => JobReal3CariModel.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to load data");
    }
  }
}
