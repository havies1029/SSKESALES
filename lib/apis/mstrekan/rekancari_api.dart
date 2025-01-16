import 'dart:convert';
import 'package:esalesapp/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:esalesapp/models/mstrekan/rekancari_model.dart';

class RekanCariAPI {
  String urlGetListEndPoint =
      "${AppData.prefixEndPoint}/api/mstrekan/rekancari/getlist";

  Future<List<RekanCariModel>> getRekanCariAPI(
      String rekanTypeId, String searchText, bool filterUnassigned, int hal) async {
    Map<String, String> queryParams = {
      "rekanTypeId": rekanTypeId,
      "searchText": searchText,
      "filterUnassigned": filterUnassigned.toString(),
      "hal": hal.toString()
    };
    var uri =
        AppData.uriHtpp(AppData.httpAuthority, urlGetListEndPoint, queryParams);

    final http.Response response =
        await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/json; odata=verbos',
      'Accept': 'application/json; odata=verbos',
      'Authorization': 'Bearer ${AppData.userToken}'
    });

    //debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<RekanCariModel>((json) => RekanCariModel.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to load data");
    }
  }
}
