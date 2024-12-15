import 'dart:convert';
import 'package:esalesapp/common/app_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:esalesapp/models/jobreal/newbriefinginitvalue_model.dart';

class NewbriefinginitvalueAPI {
  Future<NewBriefingInitValueModel> getNewbriefinginitvalueAPI(String jobId, String jobCatId) async {
    
    //debugPrint("NewbriefinginitvalueAPI");

    String urlGetListEndPoint =
        "${AppData.prefixEndPoint}/api/jobreal/newbriefinginitvalue/read";

    Map<String, String> queryParams = {
      "jobId": jobId,
      "jobCatId": jobCatId
    };

    var uri = Uri.http(AppData.httpAuthority, urlGetListEndPoint, queryParams);
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

      NewBriefingInitValueModel newBriefingInitValue =
          NewBriefingInitValueModel.fromJson(json.decode(response.body));
      return newBriefingInitValue;
    } else {
      throw Exception("Failed to load data");
    }
  }
}
