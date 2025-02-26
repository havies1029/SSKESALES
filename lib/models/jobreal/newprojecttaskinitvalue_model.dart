import 'package:esalesapp/models/combobox/combocustomer_model.dart';
import 'package:esalesapp/models/combobox/combojob_model.dart';
import 'package:esalesapp/models/combobox/combojobcat_model.dart';
import 'package:esalesapp/models/combobox/combomproject_model.dart';

class NewProjectTaskInitValueModel {
  String? mjobId;
  ComboJobModel? comboJob;
  String? mjobcatId;
  String? projectId;
  ComboJobcatModel? comboJobcat;
  String? mrekanId;
  ComboCustomerModel? comboCustomer;
  ComboMProjectModel? comboProject;

  NewProjectTaskInitValueModel(
      {required this.mjobId,
      this.comboJob,
      this.mjobcatId,
      this.comboJobcat,
      this.mrekanId,
      this.comboCustomer,
      this.projectId,
      this.comboProject});

  factory NewProjectTaskInitValueModel.fromJson(Map<String, dynamic> data) {
    ComboJobModel? comboJob;
    if (data['comboJob'] != null) {
      comboJob = ComboJobModel.fromJson(data['comboJob']);
    }

    ComboJobcatModel? comboJobcat;
    if (data['comboJobcat'] != null) {
      comboJobcat = ComboJobcatModel.fromJson(data['comboJobcat']);
    }

    ComboCustomerModel? comboCustomer;
    if (data['comboCustomer'] != null) {
      comboCustomer = ComboCustomerModel.fromJson(data['comboCustomer']);
    }

    ComboMProjectModel? comboProject;
    if (data['comboProject'] != null) {
      comboProject = ComboMProjectModel.fromJson(data['comboProject']);
    }

    return NewProjectTaskInitValueModel(
        mjobId: data['mjobId'] ?? '',
        comboJob: comboJob,
        mjobcatId: data['mjobcatId'] ?? '',
        comboJobcat: comboJobcat,
        mrekanId: data['mrekanId'] ?? '',
        comboCustomer: comboCustomer,
        projectId: data['projectId'] ?? '',
        comboProject: comboProject);
  }

  Map<String, dynamic> toJson() => {
        'mjobId': mjobId,
        'comboJob': comboJob?.toJson(),
        'mjobcatId': mjobcatId,
        'comboJobcat': comboJobcat?.toJson(),
        'mrekanId': mrekanId,
        'comboCustomer': comboCustomer?.toJson(),
        'projectId': projectId,
        'comboProject': comboProject?.toJson()
      };
}
