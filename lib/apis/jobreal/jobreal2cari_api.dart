import 'dart:convert';
import 'package:esalesapp/common/app_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:esalesapp/models/jobreal/jobreal2cari_model.dart';

class JobReal2CariAPI {  

  Future<List<JobReal2CariModel>> getJobReal2CariAPI(
      String custId, String? jobcatId, String? jobreal1Id) async {

    String urlGetListEndPoint =
      "${AppData.prefixEndPoint}/api/jobreal/jobreal2cari/getlist";

    Map<String, String> queryParams = {
      "custId": custId,
      "jobcatId": jobcatId ?? "",
      "jobreal1Id": jobreal1Id ?? ""
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

  Future<List<JobReal2CariModel>> getJobReal2ListAPI(String jobreal1Id) async {

    String urlGetListEndPoint =
      "${AppData.prefixEndPoint}/api/jobreal/jobreal2crud/getlist";

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

    debugPrint("getJobReal2ListAPI");
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
}
