import 'dart:convert';
import 'package:esalesapp/common/app_data.dart';
import 'package:esalesapp/models/jobreal/newprojecttaskinitvalue_model.dart';
import 'package:http/http.dart' as http;

class NewProjectTaskInitValueAPI {
  Future<NewProjectTaskInitValueModel> getNewProjectInitValueAPI(String plan1Id) async {
    
    //debugPrint("NewbriefinginitvalueAPI");

    String urlGetListEndPoint =
        "${AppData.prefixEndPoint}/api/jobreal/newprojectreleasetaskinitvalue/read";

    Map<String, String> queryParams = {
      "plan1Id": plan1Id
    };

    var uri = AppData.uriHtpp(AppData.httpAuthority, urlGetListEndPoint, queryParams);
    final http.Response response =
        await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/json; odata=verbos',
      'Accept': 'application/json; odata=verbos',
      'Authorization': 'Bearer ${AppData.userToken}'
    });
    
    //debugPrint("urlGetListEndPoint :$urlGetListEndPoint");
    //debugPrint("response.statusCode :${response.statusCode}");

    if (response.statusCode == 200) {

      //debugPrint("response.body :${response.body}");

      NewProjectTaskInitValueModel newProjectTaskInitValue =
          NewProjectTaskInitValueModel.fromJson(json.decode(response.body));
      return newProjectTaskInitValue;
    } else {
      throw Exception("Failed to load data");
    }
  }
}
