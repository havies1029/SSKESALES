import 'package:esalesapp/models/combobox/combocustomer_model.dart';
import 'package:flutter/foundation.dart';

class ProjectCrudModel {
  DateTime dateline;
  String mprojectId;
  String projectNama;
  String? mrekanId;
  ComboCustomerModel? comboCustomer;

  ProjectCrudModel(
      {required this.dateline,
      required this.mprojectId,
      required this.projectNama,
      this.mrekanId,
      this.comboCustomer});

  factory ProjectCrudModel.fromJson(Map<String, dynamic> data) {
    ComboCustomerModel? comboCustomer;
    if (data['comboCustomer'] != null) {
      comboCustomer = ComboCustomerModel.fromJson(data['comboCustomer']);
    }

    debugPrint("comboCustomer fromJson : ${comboCustomer.toString()}");

    return ProjectCrudModel(
        dateline:
            DateTime.tryParse(data['dateline'].toString()) ?? DateTime.now(),
        mprojectId: data['mprojectId'] ?? '',
        projectNama: data['projectNama'] ?? '',
        mrekanId: data['mrekanId'] ?? '',
        comboCustomer: comboCustomer);
  }

  Map<String, dynamic> toJson() => {
        'dateline': dateline.toIso8601String(),
        'mprojectId': mprojectId,
        'projectNama': projectNama,
        'mrekanId': mrekanId,
        'comboCustomer': comboCustomer?.toJson()
      };
}
