import 'package:esalesapp/models/combobox/combocob_model.dart';
import 'package:esalesapp/models/combobox/combocustomer_model.dart';
import 'package:esalesapp/models/combobox/combommstjobcat_model.dart';

class ProjectCrudModel {
  DateTime dateline;
  String mprojectId;
  String projectNama;
  String mrekanId;
  String mcobId;
  String mmstjobcatId;
  ComboCustomerModel? comboCustomer;
  ComboCobModel? comboCob;
  ComboMMstJobcatModel? comboMstJobCat;

  ProjectCrudModel(
      {required this.dateline,
      required this.mprojectId,
      required this.projectNama,
      required this.mrekanId,
      required this.mcobId,
      required this.mmstjobcatId,
      this.comboCustomer,
      this.comboCob,
      this.comboMstJobCat});

  factory ProjectCrudModel.fromJson(Map<String, dynamic> data) {
    ComboCustomerModel? comboCustomer;
    if (data['comboCustomer'] != null) {
      comboCustomer = ComboCustomerModel.fromJson(data['comboCustomer']);
    }

    ComboCobModel? comboCob;
    if (data['comboCob'] != null) {
      comboCob = ComboCobModel.fromJson(data['comboCob']);
    }

    ComboMMstJobcatModel? comboMstJobCat;
    if (data['comboMstJobCat'] != null) {
      comboMstJobCat = ComboMMstJobcatModel.fromJson(data['comboMstJobCat']);
    }

    //debugPrint("comboCustomer fromJson : ${comboCustomer.toString()}");

    return ProjectCrudModel(
        dateline:
            DateTime.tryParse(data['dateline'].toString()) ?? DateTime.now(),
        mprojectId: data['mprojectId'] ?? '',
        projectNama: data['projectNama'] ?? '',
        mrekanId: data['mrekanId'] ?? '',
        mcobId: data['mcobId'] ?? '',
        mmstjobcatId: data['mmstjobcatId'] ?? '',
        comboCustomer: comboCustomer,
        comboCob: comboCob,
        comboMstJobCat: comboMstJobCat);
  }

  Map<String, dynamic> toJson() => {
        'dateline': dateline.toIso8601String(),
        'mprojectId': mprojectId,
        'projectNama': projectNama,
        'mrekanId': mrekanId,
        'mcobId': mcobId,
        'mmstjobcatId': mmstjobcatId,
        'comboCustomer': comboCustomer?.toJson(),
        'comboCob': comboCob?.toJson(),
        'comboMstJobCat': comboMstJobCat?.toJson()
      };
}
