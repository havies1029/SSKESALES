import 'dart:convert';
import 'package:esalesapp/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:esalesapp/models/soaclient/tasksoainit_model.dart';

class TasksoainitAPI {
  Future<TasksoainitModel> getTasksoainitAPI(String dn1Id) async {
    String urlGetListEndPoint =
        "${AppData.prefixEndPoint}/api/soaclient/tasksoainit/getinitvalue";
    Map<String, String> queryParams = {
      "dn1Id": dn1Id,
    };

    var uri =
        AppData.uriHtpp(AppData.httpAuthority, urlGetListEndPoint, queryParams);
    final http.Response response =
        await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/json; odata=verbos',
      'Accept': 'application/json; odata=verbos',
      'Authorization': 'Bearer ${AppData.userToken}'
    });

    if (response.statusCode == 200) {
      TasksoainitModel task =
          TasksoainitModel.fromJson(json.decode(response.body));

      return task;
    } else {
      throw Exception("Failed to load data");
    }
  }
}
