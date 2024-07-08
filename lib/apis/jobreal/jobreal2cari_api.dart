import 'dart:convert';
import 'package:esalesapp/common/app_data.dart';
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:esalesapp/models/jobreal/jobreal2cari_model.dart';

class JobReal2CariAPI {
  Future<List<JobReal2CariModel>> getJobReal2CariAPI(
      String custId, String? jobreal1Id, String? searchText) async {
    String urlGetListEndPoint =
        "${AppData.prefixEndPoint}/api/jobreal/jobreal2cari/getlist";

    Map<String, String> queryParams = {
      "custId": custId,
      "jobreal1Id": jobreal1Id ?? "",
      "searchText": searchText ?? ""
    };
    var uri = Uri.http(AppData.httpAuthority, urlGetListEndPoint, queryParams);
    final http.Response response =
        await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/json; odata=verbos',
      'Accept': 'application/json; odata=verbos',
      'Authorization': 'Bearer ${AppData.userToken}'
    });

    debugPrint("getJobReal2CariAPI");
    debugPrint("response.statusCode : ${response.statusCode}");
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<JobReal2CariModel>((json) => JobReal2CariModel.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<List<JobReal2CariModel>> getJobReal2GridAPI(String jobreal1Id) async {
    String urlGetListEndPoint =
        "${AppData.prefixEndPoint}/api/jobreal/jobreal2crud/getlist";

    Map<String, String> queryParams = {"jobreal1Id": jobreal1Id};
    var uri = Uri.http(AppData.httpAuthority, urlGetListEndPoint, queryParams);
    final http.Response response =
        await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/json; odata=verbos',
      'Accept': 'application/json; odata=verbos',
      'Authorization': 'Bearer ${AppData.userToken}'
    });

    //debugPrint("getJobReal2GridAPI");
    //debugPrint("response.statusCode : ${response.statusCode}");
    //debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<JobReal2CariModel>((json) => JobReal2CariModel.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<ReturnDataAPI> jobReal2UpdateListAPI(
      String jobreal1Id, List<JobReal2CariCheckboxModel> listChecked) async {
    debugPrint("jobReal2UpdateListAPI");
    String updateListEndpoint =
        "${AppData.prefixEndPoint}/api/jobreal/jobreal2crud/updatelistchecked";
    Map<String, String> queryParams = {
      "jobreal1Id": jobreal1Id,
      "modul_id": "jobReal2UpdateListAPI"
    };
    var uri =
        AppData.uriHtpp(AppData.httpAuthority, updateListEndpoint, queryParams);

    ReturnDataAPI returnData;
    final http.Response response = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; odata=verbos',
          'Accept': 'application/json; odata=verbos',
          'Authorization': 'Bearer ${AppData.userToken}'
        },
        body: jsonEncode(listChecked));

    //debugPrint("response.statusCode : ${response.statusCode}");

    if (response.statusCode == 200) {
      returnData = ReturnDataAPI.fromDatabaseJson(jsonDecode(response.body));
    } else {
      debugPrint("response.body : ${response.body}");
      returnData = ReturnDataAPI(success: false, data: "", rowcount: 0);
    }
    return returnData;
  }

  Future<ReturnDataAPI> deleteAllJobReal2GridAPI(String jobreal1Id) async {
    String urlEndPoint =
        "${AppData.prefixEndPoint}/api/jobreal/jobreal2crud/hapusall";
    ReturnDataAPI returnData;
    Map<String, String> queryParams = {"jobreal1Id": jobreal1Id};
    var uri = AppData.uriHtpp(AppData.httpAuthority, urlEndPoint, queryParams);
    final http.Response response =
        await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/json; odata=verbos',
      'Accept': 'application/json; odata=verbos',
      'Authorization': 'Bearer ${AppData.userToken}'
    });

    debugPrint("deleteAllJobReal2GridAPI");
    debugPrint("urlEndPoint : $urlEndPoint");
    debugPrint("response.statusCode : ${response.statusCode}");
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      returnData = ReturnDataAPI.fromDatabaseJson(jsonDecode(response.body));
    } else {
      debugPrint("response.body : ${response.body}");
      returnData = ReturnDataAPI(success: false, data: "", rowcount: 0);
    }
    return returnData;
  }
}
