import 'dart:convert';
import 'package:esalesapp/common/app_data.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:esalesapp/models/combobox/combojob_model.dart';

class ComboJobAPI {
  Future<List<ComboJobModel>> getComboJobAPI(String mjobcatId) async {
    String urlGetComboEndPoint =
        "${AppData.prefixEndPoint}/api/mjobcombobox/getlist";

    Map<String, String> queryParams = {"mjobcatId": mjobcatId};

    var uri = AppData.uriHtpp(
        AppData.httpAuthority, urlGetComboEndPoint, queryParams);
    final http.Response response =
        await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/json; odata=verbos',
      'Accept': 'application/json; odata=verbos',
      'Authorization': 'Bearer ${AppData.userToken}'
    });

    debugPrint("mjobcatId : $mjobcatId");
    debugPrint("response.statusCode : ${response.statusCode}");
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<ComboJobModel>((json) => ComboJobModel.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to load data");
    }
  }
}
