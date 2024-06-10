import 'dart:convert';
import 'package:esalesapp/common/app_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:esalesapp/models/combobox/combocustcat_model.dart';

class ComboCustCatAPI {
  Future<List<ComboCustCatModel>> getComboCustCatAPI(String usage) async {
    String urlGetComboEndPoint =
        "${AppData.prefixEndPoint}/api/mcustcatcombobox/getlist";
    Map<String, String> queryParams = {"usage": usage};

    var uri = AppData.uriHtpp(
        AppData.httpAuthority, urlGetComboEndPoint, queryParams);
    final http.Response response =
        await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/json; odata=verbos',
      'Accept': 'application/json; odata=verbos',
      'Authorization': 'Bearer ${AppData.userToken}'
    });

    debugPrint("getComboCustCatAPI");
    debugPrint("response.statusCode : ${response.statusCode}");
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<ComboCustCatModel>((json) => ComboCustCatModel.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to load data");
    }
  }
}
