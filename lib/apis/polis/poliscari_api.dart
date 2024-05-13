import 'dart:convert';
import 'package:esalesapp/common/app_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:esalesapp/models/polis/poliscari_model.dart';

class PolisCariAPI {
  String urlGetListEndPoint =
      "${AppData.prefixEndPoint}/api/polis/poliscari/getlist";

  Future<List<PolisCariModel>> getPolisCariAPI(
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

    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<PolisCariModel>((json) => PolisCariModel.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to load data");
    }
  }
}
