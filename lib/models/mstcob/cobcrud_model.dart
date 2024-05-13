
class CobCrudModel {
	String cobNama;
	String mcobId;
	String shortName;

	CobCrudModel({required this.cobNama, required this.mcobId, 
		required this.shortName});

	factory CobCrudModel.fromJson(Map<String, dynamic> data) {
		return CobCrudModel(
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
