
class CustCatCrudModel {
	String catName;
	String mcustcatId;

	CustCatCrudModel({required this.catName, required this.mcustcatId});

	factory CustCatCrudModel.fromJson(Map<String, dynamic> data) {
		return CustCatCrudModel(
			catName: data['catName']??'',
			mcustcatId: data['mcustcatId']??''
		);

	}

	Map<String, dynamic> toJson() =>
		{'catName': catName,
		'mcustcatId': mcustcatId};

}
