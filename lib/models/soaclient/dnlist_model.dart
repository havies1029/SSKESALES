class DnlistModel {
  double dnAmount;
  double dnBayar;
  DateTime dnTgl;
  String dn1Id;
  DateTime extDate;
  DateTime jthTempo;
  String curr;
  String sppaNo;
  int aging;
  String insuredName;
  String cobName;
  int severity;

  DnlistModel(
      {required this.dnAmount,
      required this.dnBayar,
      required this.dnTgl,
      required this.dn1Id,
      required this.extDate,
      required this.jthTempo,
      required this.curr,
      required this.sppaNo,
      required this.aging,
      required this.insuredName,
      required this.cobName,
      required this.severity});

  factory DnlistModel.fromJson(Map<String, dynamic> data) {
    return DnlistModel(
        dnAmount: double.tryParse(data['dnAmount'].toString()) ?? 0,
        dnBayar: double.tryParse(data['dnBayar'].toString()) ?? 0,
        dnTgl: DateTime.tryParse(data['dnTgl'].toString()) ?? DateTime.now(),
        dn1Id: data['dn1Id'] ?? '',
        extDate:
            DateTime.tryParse(data['extDate'].toString()) ?? DateTime.now(),
        jthTempo:
            DateTime.tryParse(data['jthTempo'].toString()) ?? DateTime.now(),
        curr: data['curr'] ?? '',
        sppaNo: data['sppaNo'] ?? '',
        aging: int.tryParse(data['aging'].toString()) ?? 0,        
        insuredName: data['insuredName'] ?? '',
        cobName: data['cobName'] ?? '',
        severity: int.tryParse(data['severity'].toString()) ?? 1);
  }

  Map<String, dynamic> toJson() => {
        'dnAmount': dnAmount.toString(),
        'dnBayar': dnBayar.toString(),
        'dnTgl': dnTgl.toIso8601String(),
        'dn1Id': dn1Id,
        'extDate': extDate.toIso8601String(),
        'jthTempo': jthTempo.toIso8601String(),
        'curr': curr,
        'sppaNo': sppaNo,
        'aging': aging.toString(),
        'insuredName': insuredName,
        'cobName': cobName,
        'severity': severity.toString()
      };
}
