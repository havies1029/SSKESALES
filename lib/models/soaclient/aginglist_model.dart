class AginglistModel {
  String agingDesc;
  String msoaagingId;
  int range1;
  int range2;
  int dnCount;
  double osAmount;
  int severity;

  AginglistModel(
      {required this.agingDesc,
      required this.msoaagingId,
      required this.range1,
      required this.range2,
      required this.dnCount,
      required this.osAmount,
      required this.severity});

  factory AginglistModel.fromJson(Map<String, dynamic> data) {
    return AginglistModel(
        agingDesc: data['agingDesc'] ?? '',
        msoaagingId: data['msoaagingId'] ?? '',
        range1: int.tryParse(data['range1'].toString()) ?? 0,
        range2: int.tryParse(data['range2'].toString()) ?? 0,
        dnCount: int.tryParse(data['dnCount'].toString()) ?? 0,
        osAmount: double.tryParse(data['osAmount'].toString()) ?? 0,
        severity: int.tryParse(data['severity'].toString()) ?? 1);
  }

  Map<String, dynamic> toJson() => {
        'agingDesc': agingDesc,
        'msoaagingId': msoaagingId,
        'range1': range1.toString(),
        'range2': range2.toString(),
        'dnCount': dnCount.toString(),
        'osAmount': osAmount.toString(),
        'severity': severity.toString()
      };
}
