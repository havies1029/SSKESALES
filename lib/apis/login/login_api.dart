import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:esalesapp/models/authentication/auth_model.dart';
import 'package:esalesapp/common/app_data.dart';
import 'package:esalesapp/models/user/user_model.dart';

final _base = AppData.apiDomain;
const _tokenEndpoint = "api/login/apilogin";
final _tokenURL = _base + _tokenEndpoint;

Future<Token> getToken(UserLogin userLogin) async {
  UserInfo userinfo = UserInfo(userLogin: userLogin);

  debugPrint(_tokenURL);
  final http.Response response = await http.post(Uri.parse(_tokenURL),
      headers: <String, String>{
        'Content-Type': 'application/json; odata=verbos',
        'Accept': 'application/json; odata=verbos'
      },
      //body: jsonEncode(userLogin.toDatabaseJson()),
      body: jsonEncode(userinfo.toJson()));

  //debugPrint(jsonEncode(userinfo.toJson()));

  //debugPrint("response.statusCode : ${response.statusCode}");

  if (response.statusCode == 200) {
    //debugPrint("Berhasil Login");
    debugPrint(jsonDecode(response.body));
    return Token.split(userLogin.username!, jsonDecode(response.body));
  } else {
    throw Exception(json.decode(response.body));
  }
}

Future<User> validateUserLogin(UserLogin userLogin) async {
  UserInfo userinfo = UserInfo(userLogin: userLogin);

  debugPrint("validateUserLogin #10");

  debugPrint(_tokenURL);
  final http.Response response = await http.post(Uri.parse(_tokenURL),
      headers: <String, String>{
        'Content-Type': 'application/json; odata=verbos',
        'Accept': 'application/json; odata=verbos'
      },
      //body: jsonEncode(userLogin.toDatabaseJson()),
      body: jsonEncode(userinfo.toJson()));

  //debugPrint(jsonEncode(userinfo.toJson()));

  //debugPrint("response.statusCode : ${response.statusCode}");

  //debugPrint("validateUserLogin #20");

  if (response.statusCode == 200) {
    //debugPrint("Berhasil Login #10");

    //debugPrint(jsonDecode(response.body));

    String tokeninfo = jsonDecode(response.body);
    List<String> info = tokeninfo.split(";");

    Token token = Token.split(userLogin.username!, jsonDecode(response.body));

    //debugPrint("Berhasil Login #20");

    try {
      User user = User(
          id: 0,
          token: token.token,
          username: userLogin.username,
          nama: info[2],
          hp: info[4],
          email: info[5],
          );
      return user;
    } on Exception catch (e) {
      debugPrint("Error : ${e.toString()}");
      rethrow;
    }
    
  } else {
    //debugPrint("validateUserLogin #25");
    //debugPrint(jsonDecode(response.body));
    throw Exception(json.decode(response.body));
  }
}
