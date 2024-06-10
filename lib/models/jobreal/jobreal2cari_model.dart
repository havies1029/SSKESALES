import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

class JobReal2CariCheckboxModel {
  String polis1Id;
  bool isChecked = false;

  JobReal2CariCheckboxModel({required this.polis1Id, required this.isChecked});

  factory JobReal2CariCheckboxModel.fromJson(Map<String, dynamic> data) {
    return JobReal2CariCheckboxModel(
        polis1Id: data['polis1Id'] ?? '', 
        isChecked: toBoolean(data['isChecked'].toString())
        );
  }

  Map<String, dynamic> toJson() =>
      {'polis1Id': polis1Id, 'isChecked': isChecked.toString()};
}

class JobReal2CariModel {
  String polis1Id;
  String polisNo;
  DateTime periodeAwal;
  DateTime? periodeAkhir;
  String curr;
  double cstPremi;
  double tsi;
  String cob;
  String insuredNama;
  String jobreal2Id;
  bool isChecked = false;

  JobReal2CariModel(
      {required this.polis1Id,
      required this.polisNo,
      required this.periodeAwal,
      this.periodeAkhir,
      required this.curr,
      required this.cstPremi,
      required this.tsi,
      required this.cob,
      required this.insuredNama,
      required this.jobreal2Id,
      required this.isChecked});

  factory JobReal2CariModel.fromJson(Map<String, dynamic> data) {
    debugPrint("data['isChecked'] : ${data['isChecked']}");
    return JobReal2CariModel(
        polis1Id: data['polis1Id'] ?? '',
        polisNo: data['polisNo'] ?? '',
        periodeAwal:
            DateTime.tryParse(data['periodeAwal'].toString()) ?? DateTime.now(),
        periodeAkhir: data['periodeAkhir'] != null ? DateTime.tryParse(data['periodeAkhir'].toString()):null,
        curr: data['curr'] ?? '',
        cstPremi: double.tryParse(data['cstPremi'].toString()) ?? 0,
        tsi: double.tryParse(data['tsi'].toString()) ?? 0,
        cob: data['cob'] ?? '',
        insuredNama: data['insuredNama'] ?? '',
        jobreal2Id: data['jobreal2Id'] ?? '',
        //isChecked: false
        isChecked: toBoolean(data['isChecked'].toString(), true));
  }

  Map<String, dynamic> toJson() => {
        'polis1Id': polis1Id,
        'polisNo': polisNo,
        'periodeAwal': periodeAwal.toIso8601String(),
        'periodeAkhir': periodeAkhir?.toIso8601String()??"",
        'curr': curr,
        'cstPremi': cstPremi.toString(),
        'tsi': tsi.toString(),
        'cob': cob,
        'insuredNama': insuredNama,
        'jobreal2Id': jobreal2Id,
        'isChecked': isChecked.toString()
      };
}
