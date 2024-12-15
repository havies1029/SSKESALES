import 'dart:convert';
import 'package:esalesapp/common/app_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:esalesapp/models/combobox/combojobcatgroup_model.dart';

class ComboJobcatgroupAPI {
  Future<List<ComboJobcatgroupModel>> getComboJobcatgroupAPI() async {
    debugPrint("getComboJobcatgroupAPI");

    String urlGetComboEndPoint =
        "${AppData.prefixEndPoint}/api/mjobcatgroupcombobox/getlist";

    var uri = AppData.uriHtpp(AppData.httpAuthority, urlGetComboEndPoint);
    final http.Response response =
        await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/json; odata=verbos',
      'Accept': 'application/json; odata=verbos',
      'Authorization': 'Bearer ${AppData.userToken}'
    });

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<ComboJobcatgroupModel>(
              (json) => ComboJobcatgroupModel.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<List<ComboJobcatgroupModel>> getComboJobcatgroupByPersonIdAPI(
      String personId) async {
    debugPrint("getComboJobcatgroupByPersonIdAPI");

    Map<String, String> queryParams = {
      "personId": personId,
    };

    String urlGetComboEndPoint =
        "${AppData.prefixEndPoint}/api/mjobcatgroupcombobox/getlist/bypersonid";

    var uri = AppData.uriHtpp(
        AppData.httpAuthority, urlGetComboEndPoint, queryParams);
    final http.Response response =
        await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/json; odata=verbos',
      'Accept': 'application/json; odata=verbos',
      'Authorization': 'Bearer ${AppData.userToken}'
    });

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<ComboJobcatgroupModel>(
              (json) => ComboJobcatgroupModel.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<ComboJobcatgroupModel> getComboJobcatgroupOtherAPI() async {
    debugPrint("getComboJobcatgroupOtherAPI");

    String urlGetComboEndPoint =
        "${AppData.prefixEndPoint}/api/mjobcatgroupcombobox/getmjobcatgroupother";

    var uri = AppData.uriHtpp(AppData.httpAuthority, urlGetComboEndPoint);
    final http.Response response =
        await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/json; odata=verbos',
      'Accept': 'application/json; odata=verbos',
      'Authorization': 'Bearer ${AppData.userToken}'
    });

    debugPrint("urlGetComboEndPoint : $urlGetComboEndPoint");
    debugPrint("response.statusCode : ${response.statusCode}");
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      return ComboJobcatgroupModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load data");
    }
  }
}
