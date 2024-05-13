class PolisCariModel {
  double cstPremi;
  String insuredNama;
  DateTime periodeAkhir;
  DateTime periodeAwal;
  String polisNo;
  String polis1Id;
  double tsi;
  String? cobNama;
  String rekanNama;

  PolisCariModel(
      {required this.cstPremi,
      required this.insuredNama,
      required this.periodeAkhir,
      required this.periodeAwal,
      required this.polisNo,
      required this.polis1Id,
      required this.tsi,
      this.cobNama,
      required this.rekanNama});

  factory PolisCariModel.fromJson(Map<String, dynamic> data) {
    return PolisCariModel(
        cstPremi: double.tryParse(data['cstPremi'].toString()) ?? 0,
        insuredNama: data['insuredNama'] ?? '',
        periodeAkhir: DateTime.tryParse(data['periodeAkhir'].toString()) ??
            DateTime.now(),
        periodeAwal:
            DateTime.tryParse(data['periodeAwal'].toString()) ?? DateTime.now(),
        polisNo: data['polisNo'] ?? '',
        polis1Id: data['polis1Id'] ?? '',
        rekanNama: data['rekanNama'] ?? '',
        tsi: double.tryParse(data['tsi'].toString()) ?? 0,
        cobNama: data['cobNama'] ?? '');
  }

  Map<String, dynamic> toJson() => {
        'cstPremi': cstPremi.toString(),
        'insuredNama': insuredNama,
        'periodeAkhir': periodeAkhir.toIso8601String(),
        'periodeAwal': periodeAwal.toIso8601String(),
        'polisNo': polisNo,
        'polis1Id': polis1Id,
        'tsi': tsi.toString(),
        'cobNama': cobNama,
        'rekanNama': rekanNama
      };
}
