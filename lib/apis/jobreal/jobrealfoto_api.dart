import 'dart:convert';
import 'package:esalesapp/common/app_data.dart';
import 'package:esalesapp/models/image/downloadfileinfo64.dart';
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class JobRealFotoAPI {
  Future<ReturnDataAPI> uploadFotoJobReal(
      String jobReal1Id, String filePath) async {
    String base = AppData.apiDomain;
    String uploadFotoEndpoint = "api/jobreal/jobrealcrud/uploadfoto";
    String uploadFotoURL = base + uploadFotoEndpoint;

    ReturnDataAPI returnData =
        ReturnDataAPI(success: false, data: "", rowcount: 0);

    var request = http.MultipartRequest('POST', Uri.parse(uploadFotoURL));
    request.headers.addAll(AppData.httpHeaders);
    request.fields['jobReal1Id'] = jobReal1Id;

    request.files
        .add(await http.MultipartFile.fromPath('image_file', filePath));
    await request.send().then((response) {
      if (response.statusCode == 200) {
        debugPrint("Success send Image");

        response.stream.transform(utf8.decoder).listen((value) {
          debugPrint(value);
        });
        //returnData = ReturnDataAPI.fromDatabaseJson(jsonDecode(response.));
      } else {
        debugPrint("Error send Image");
      }
    });
    return returnData;
  }

  Future<DownloadFileInfo64Model?> downloadFotoJobRealAPI(
      String jobReal1Id) async {
    DownloadFileInfo64Model? fileInfo;

    String urlGetFileEndPoint =
        "${AppData.prefixEndPoint}/api/jobreal/jobrealcrud/getfoto64";

    Map<String, String> queryParams = {
      "jobReal1Id": jobReal1Id,
    };

    debugPrint("downloadFotoJobRealAPI #10");

    var uri =
        AppData.uriHtpp(AppData.httpAuthority, urlGetFileEndPoint, queryParams);
    final http.Response response =
        await http.get(uri, headers: AppData.httpHeaders);

    debugPrint("downloadFotoJobRealAPI #20");

    debugPrint(
        "downloadFotoJobRealAPI response.statusCode : ${response.statusCode}");

    if (response.statusCode == 200) {
      debugPrint(
          "downloadFotoJobRealAPI -> response.body #30: ${response.body}");

      fileInfo =
          DownloadFileInfo64Model.fromJson(jsonDecode(response.body));

      debugPrint("fileInfo.namafile : ${fileInfo.namafile}");

    } 
    return fileInfo;
    
  }

  Future<bool> jobRealCrudHapusFotoAPI(String jobreal1Id) async {
    String hapusEndpoint =
        "${AppData.prefixEndPoint}/api/jobreal/jobrealcrud/hapusfoto";
    Map<String, String> queryParams = {
      'jobreal1Id': jobreal1Id,
      'modul_id': 'jobRealCrudHapusFotoAPI'
    };
    var uri =
        AppData.uriHtpp(AppData.httpAuthority, hapusEndpoint, queryParams);
    final http.Response response =
        await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/json; odata=verbos',
      'Accept': 'application/json; odata=verbos',
      'Authorization': 'Bearer ${AppData.userToken}'
    });

    ReturnDataAPI returnData;
    if (response.statusCode == 200) {
      returnData = ReturnDataAPI.fromDatabaseJson(jsonDecode(response.body));
    } else {
      returnData = ReturnDataAPI(success: false, data: "", rowcount: 0);
    }

    return returnData.success;
  }
}
