import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

class OnBoardMenuCariModel {
  bool clientassignment = false;
  bool policyoutstanding = false;

  OnBoardMenuCariModel(
      {required this.clientassignment, required this.policyoutstanding});

  factory OnBoardMenuCariModel.fromJson(Map<String, dynamic> data) {
    debugPrint(
        "toBoolean(data['policyoutstanding'].toString()) : ${toBoolean(data['policyoutstanding'].toString())}");

    return OnBoardMenuCariModel(
        clientassignment: toBoolean(data['clientassignment'].toString()),
        policyoutstanding: toBoolean(data['policyoutstanding'].toString()));
  }

  Map<String, dynamic> toJson() => {
        'clientassignment': clientassignment.toString(),
        'policyoutstanding': policyoutstanding.toString()
      };
}
