import 'package:esalesapp/models/combobox/combocob_model.dart';
import 'package:esalesapp/models/combobox/combocustomer_model.dart';
import 'package:esalesapp/models/combobox/combojobcat_model.dart';

class TasksoainitModel {
  String materi;
  String mjobcatId;
  String mrekanId;
  String tasksoainitId;
  ComboJobcatModel comboJobcat;
  ComboCustomerModel comboCustomer;
  ComboCobModel comboCob;

  TasksoainitModel(
      {required this.materi,
      required this.mjobcatId,
      required this.mrekanId,
      required this.tasksoainitId,
      required this.comboJobcat,
      required this.comboCustomer,
      required this.comboCob});

  factory TasksoainitModel.fromJson(Map<String, dynamic> data) {
    ComboJobcatModel comboJobcat;
    comboJobcat = ComboJobcatModel.fromJson(data['comboJobcat']);

    ComboCustomerModel comboCustomer;
    comboCustomer = ComboCustomerModel.fromJson(data['comboCustomer']);

    ComboCobModel comboCob;
    comboCob = ComboCobModel.fromJson(data['comboCob']);

    return TasksoainitModel(
        materi: data['materi'] ?? '',
        mjobcatId: data['mjobcatId'] ?? '',
        mrekanId: data['mrekanId'] ?? '',
        tasksoainitId: data['tasksoainitId'] ?? '',
        comboJobcat: comboJobcat,
        comboCustomer: comboCustomer,
        comboCob: comboCob);
  }

  Map<String, dynamic> toJson() => {
        'materi': materi,
        'mjobcatId': mjobcatId,
        'mrekanId': mrekanId,
        'tasksoainitId': tasksoainitId,
        'comboJobcat': comboJobcat.toJson(),
        'comboCustomer': comboCustomer.toJson(),
        'comboCob': comboCob.toJson()
      };
}
