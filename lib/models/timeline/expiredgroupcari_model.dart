
class ExpiredGroupCariModel {
	String expgroupId;
	String groupNama;
	int jml;
	int noUrut;

	ExpiredGroupCariModel({required this.expgroupId, required this.groupNama, 
		required this.jml, required this.noUrut});

	factory ExpiredGroupCariModel.fromJson(Map<String, dynamic> data) {
		return ExpiredGroupCariModel(
			expgroupId: data['expgroupId']??'',
			groupNama: data['groupNama']??'',
			jml: int.tryParse(data['jml'].toString())??0,
			noUrut: int.tryParse(data['noUrut'].toString())??10
		);

	}

	Map<String, dynamic> toJson() =>
		{'expgroupId': expgroupId,
		'groupNama': groupNama,
		'jml': jml.toString(),
		'noUrut': noUrut.toString()};

}
