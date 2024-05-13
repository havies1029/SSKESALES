
class CobCariModel {
	String cobNama;
	String mcobId;
	String shortName;

	CobCariModel({required this.cobNama, required this.mcobId, 
		required this.shortName});

	factory CobCariModel.fromJson(Map<String, dynamic> data) {
		return CobCariModel(
			cobNama: data['cobNama']??'',
			mcobId: data['mcobId']??'',
			shortName: data['shortName']??''
		);

	}

	Map<String, dynamic> toJson() =>
		{'cobNama': cobNama,
		'mcobId': mcobId,
		'shortName': shortName};

}
