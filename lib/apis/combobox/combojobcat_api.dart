import 'dart:convert';
import 'package:esalesapp/common/app_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:esalesapp/models/combobox/combojobcat_model.dart';

class ComboJobcatAPI {
  Future<List<ComboJobcatModel>> getComboJobcatAPI() async {
    String urlGetComboEndPoint =
        "${AppData.prefixEndPoint}/api/mjobcatcombobox/getlist";

    var uri = AppData.uriHtpp(AppData.httpAuthority, urlGetComboEndPoint);
    final http.Response response =
        await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/json; odata=verbos',
      'Accept': 'application/json; odata=verbos',
      'Authorization': 'Bearer ${AppData.userToken}'
    });

    debugPrint("getComboJobcatAPI");
    debugPrint("response.statusCode : ${response.statusCode}");
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<ComboJobcatModel>((json) => ComboJobcatModel.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to load data");
    }
  }
}
