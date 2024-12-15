import 'dart:convert';
import 'package:esalesapp/common/app_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:esalesapp/models/briefing/briefinglist_model.dart';

class BriefinglistAPI {
  Future<List<BriefinglistModel>> getBriefinglistAPI() async {
    //debugPrint("BriefinglistAPI #10");

    String urlGetListEndPoint =
        "${AppData.prefixEndPoint}/api/briefing/briefinglist/getlist";

    var uri = Uri.http(AppData.httpAuthority, urlGetListEndPoint);

    final http.Response response =
        await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/json; odata=verbos',
      'Accept': 'application/json; odata=verbos',
      'Authorization': 'Bearer ${AppData.userToken}'
    });

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<BriefinglistModel>((json) => BriefinglistModel.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<bool> checkHasPassedTodaysBriefing() async {
    bool hasPassed = false;
    try {
      String urlGetEndPoint =
          "${AppData.prefixEndPoint}/api/briefing/checkhaspassedbriefing";

      var uri = Uri.http(AppData.httpAuthority, urlGetEndPoint);

      final http.Response response =
          await http.get(uri, headers: <String, String>{
        'Content-Type': 'application/json; odata=verbos',
        'Accept': 'application/json; odata=verbos',
        'Authorization': 'Bearer ${AppData.userToken}'
      });

      if (response.statusCode == 200) {
        hasPassed = jsonDecode(response.body);
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      debugPrint("error : ${e.toString()}");
    }
    return hasPassed;
  }
}
