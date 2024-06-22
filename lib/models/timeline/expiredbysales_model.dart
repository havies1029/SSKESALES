
class ExpiredBySalesModel {
	int jml;
	String salesId;
	String salesNama;

	ExpiredBySalesModel({required this.jml, required this.salesId, 
		required this.salesNama});

	factory ExpiredBySalesModel.fromJson(Map<String, dynamic> data) {
		return ExpiredBySalesModel(
			jml: int.tryParse(data['jml'].toString())??0,
			salesId: data['salesId']??'',
			salesNama: data['salesNama']??''
		);

	}

	Map<String, dynamic> toJson() =>
		{'jml': jml.toString(),
		'salesId': salesId,
		'salesNama': salesNama};

}
