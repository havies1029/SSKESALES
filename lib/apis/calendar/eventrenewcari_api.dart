import 'dart:convert';

import 'package:esalesapp/common/app_data.dart';
import 'package:esalesapp/models/calendar/event_renewal_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EventRenewalCariAPI {
  String urlGetListEndPoint =
      "${AppData.prefixEndPoint}/api/event/renewal/getlist";

  Future<List<EventRenewalModel>> getEventRenewalCariAPI() async {

    var uri = AppData.uriHtpp(AppData.httpAuthority, urlGetListEndPoint);
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
          .map<EventRenewalModel>((json) => EventRenewalModel.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to load data");
    }
  }
}