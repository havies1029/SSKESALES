
class PolisExpCariModel {
	String cobNama;
	double cstPremi;
	String curr;
	String insuredNama;
	DateTime periodeAkhir;
	DateTime periodeAwal;
	String polis1Id;
	String sppaNo;
	double tsi;

	PolisExpCariModel({required this.cobNama, required this.cstPremi, 
		required this.curr, required this.insuredNama, 
		required this.periodeAkhir, required this.periodeAwal, 
		required this.polis1Id, required this.sppaNo, 
		required this.tsi});

	factory PolisExpCariModel.fromJson(Map<String, dynamic> data) {
		return PolisExpCariModel(
			cobNama: data['cobNama']??'',
			cstPremi: double.tryParse(data['cstPremi'].toString())??0,
			curr: data['curr']??'',
			insuredNama: data['insuredNama']??'',
			periodeAkhir: DateTime.tryParse(data['periodeAkhir'].toString())??DateTime.now(),
			periodeAwal: DateTime.tryParse(data['periodeAwal'].toString())??DateTime.now(),
			polis1Id: data['polis1Id']??'',
			sppaNo: data['sppaNo']??'',
			tsi: double.tryParse(data['tsi'].toString())??0
		);

	}

	Map<String, dynamic> toJson() =>
		{'cobNama': cobNama,
		'cstPremi': cstPremi.toString(),
		'curr': curr,
		'insuredNama': insuredNama,
		'periodeAkhir': periodeAkhir.toIso8601String(),
		'periodeAwal': periodeAwal.toIso8601String(),
		'polis1Id': polis1Id,
		'sppaNo': sppaNo,
		'tsi': tsi.toString()};

}
