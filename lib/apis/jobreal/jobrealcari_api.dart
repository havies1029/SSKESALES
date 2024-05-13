import 'dart:convert';
import 'package:esalesapp/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:esalesapp/models/jobreal/jobrealcari_model.dart';

class JobRealCariAPI {
  String urlGetListEndPoint =
      "${AppData.prefixEndPoint}/api/jobreal/jobrealcari/getlist";

  Future<List<JobRealCariModel>> getJobRealCariAPI(
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

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<JobRealCariModel>((json) => JobRealCariModel.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to load data");
    }
  }
}
