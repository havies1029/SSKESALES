import 'dart:convert';
import 'package:esalesapp/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:esalesapp/models/combobox/combocob_model.dart';

class ComboCobAPI {
  Future<List<ComboCobModel>> getComboCobAPI(String filter) async {
    Map<String, String> queryParams = {"filter": filter};
    String urlGetComboEndPoint =
        "${AppData.prefixEndPoint}/api/mcobcombobox/getlist";

    var uri = AppData.uriHtpp(AppData.httpAuthority, urlGetComboEndPoint, queryParams);
    final http.Response response =
        await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/json; odata=verbos',
      'Accept': 'application/json; odata=verbos',
      'Authorization': 'Bearer ${AppData.userToken}'
    });

    //debugPrint("response.statusCode :${response.statusCode}");

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<ComboCobModel>((json) => ComboCobModel.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to load data");
    }
  }
}
