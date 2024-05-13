import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:esalesapp/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:esalesapp/models/mststaff/staffcari_model.dart';

class StaffCariAPI {
  String urlGetListEndPoint =
      "${AppData.prefixEndPoint}/api/mststaff/staffcari/getlist";

  Future<List<StaffCariModel>> getStaffCariAPI(
      String searchText, int hal) async {
    Map<String, String> queryParams = {
      "searchText": searchText,
      "hal": hal.toString()
    };
    var uri = Uri.http(AppData.httpAuthority, urlGetListEndPoint, queryParams);
    final http.Response response =
        await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/json; odata=verbos',
      'Accept': 'application/json; odata=verbos',
      'Authorization': 'Bearer ${AppData.userToken}'
    });

    debugPrint("getStaffCariAPI response.body : ${response.body}");

    if (response.statusCode == 200) {
      try {
        json.decode(response.body).cast<Map<String, dynamic>>();
      } catch (e) {
        debugPrint("getStaffCariAPI error #10 : ${e.toString()}");
      }
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      try {
        parsed
            .map<StaffCariModel>((json) => StaffCariModel.fromJson(json))
            .toList();
      } catch (e) {
        debugPrint("getStaffCariAPI error #10 : ${e.toString()}");
      }

      return parsed
          .map<StaffCariModel>((json) => StaffCariModel.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to load data");
    }
  }
}
