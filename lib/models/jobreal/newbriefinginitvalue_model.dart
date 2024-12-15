import 'package:esalesapp/models/combobox/combocustomer_model.dart';
import 'package:esalesapp/models/combobox/combojob_model.dart';
import 'package:esalesapp/models/combobox/combojobcat_model.dart';
import 'package:esalesapp/models/combobox/combomedia_model.dart';

class NewBriefingInitValueModel {
  String? mjobId;
  String pic;
  String taskDesc;
  String perihal;
  ComboJobModel? comboJob;
  String? mjobcatId;
  ComboJobcatModel? comboJobcat;
  String? mmediaId;
  ComboMediaModel? comboMedia;
  String? mrekanId;
  ComboCustomerModel? comboCustomer;

  NewBriefingInitValueModel(
      {required this.mjobId,
      this.pic = "",
      this.taskDesc = "",
      this.perihal = "",
      this.comboJob,
      this.mjobcatId,
      this.comboJobcat,
      this.mmediaId,
      this.comboMedia,
      this.mrekanId,
      this.comboCustomer});

  factory NewBriefingInitValueModel.fromJson(Map<String, dynamic> data) {
    ComboJobModel? comboJob;
    if (data['comboJob'] != null) {
      comboJob = ComboJobModel.fromJson(data['comboJob']);
    }

    ComboJobcatModel? comboJobcat;
    if (data['comboJobcat'] != null) {
      comboJobcat = ComboJobcatModel.fromJson(data['comboJobcat']);
    }

    ComboMediaModel? comboMedia;
    if (data['comboMedia'] != null) {
      comboMedia = ComboMediaModel.fromJson(data['comboMedia']);
    }

    ComboCustomerModel? comboCustomer;
    if (data['comboCustomer'] != null) {
      comboCustomer = ComboCustomerModel.fromJson(data['comboCustomer']);
    }

    return NewBriefingInitValueModel(
        mjobId: data['mjobId'] ?? '',
        pic: data['pic'] ?? '',
        taskDesc: data['taskDesc'] ?? '',
        perihal: data['perihal'] ?? '',
        comboJob: comboJob,
        mjobcatId: data['mjobcatId'] ?? '',
        comboJobcat: comboJobcat,
        mmediaId: data['mmediaId'] ?? '',
        comboMedia: comboMedia,
        mrekanId: data['mrekanId'] ?? '',
        comboCustomer: comboCustomer);
  }

  Map<String, dynamic> toJson() => {
        'mjobId': mjobId,
        'pic': pic,
        'taskDesc': taskDesc,
        'perihal': perihal,
        'comboJob': comboJob?.toJson(),
        'mjobcatId': mjobcatId,
        'comboJobcat': comboJobcat?.toJson(),
        'mmediaId': mmediaId,
        'comboMedia': comboMedia?.toJson(),
        'mrekanId': mrekanId,
        'comboCustomer': comboCustomer?.toJson()
      };
}
