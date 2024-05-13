
class JobReal2CariModel {
	String polis1Id;
	String polisNo;
	DateTime periodeAwal;
	DateTime periodeAkhir;
	String curr;
	double cstPremi;
	double tsi;
	String cob;
	String insuredNama;
	String jobreal2Id;

	JobReal2CariModel({required this.polis1Id, required this.polisNo, 
    required this.periodeAwal, required this.periodeAkhir, 
    required this.curr, required this.cstPremi, 
    required this.tsi, required this.cob, required this.insuredNama, 
    required this.jobreal2Id});

	factory JobReal2CariModel.fromJson(Map<String, dynamic> data) {
		return JobReal2CariModel(
			polis1Id: data['polis1Id']??'',
      polisNo: data['polisNo']??'',
      periodeAwal: DateTime.tryParse(data['periodeAwal'].toString())??DateTime.now(),
      periodeAkhir: DateTime.tryParse(data['periodeAkhir'].toString())??DateTime.now(),
      curr: data['curr']??'',
      cstPremi: double.tryParse(data['cstPremi'].toString()) ?? 0,
      tsi: double.tryParse(data['tsi'].toString()) ?? 0,
      cob: data['cob']??'',
      insuredNama: data['insuredNama']??'',
      jobreal2Id: data['jobreal2Id']??''
		);

	}

	Map<String, dynamic> toJson() =>
		{'polis1Id': polis1Id,
    'polisNo': polisNo,
    'periodeAwal': periodeAwal.toIso8601String(),
    'periodeAkhir': periodeAkhir.toIso8601String(),
    'curr': curr,
    'cstPremi': cstPremi.toString(),
    'tsi': tsi.toString(),
    'cob': cob,
    'insuredNama': insuredNama,
    'jobreal2Id': jobreal2Id,
    };

}
