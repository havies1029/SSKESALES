
class CustCatCariModel {
	String catName;
	String mcustcatId;

	CustCatCariModel({required this.catName, required this.mcustcatId});

	factory CustCatCariModel.fromJson(Map<String, dynamic> data) {
		return CustCatCariModel(
			catName: data['catName']??'',
			mcustcatId: data['mcustcatId']??''
		);

	}

	Map<String, dynamic> toJson() =>
		{'catName': catName,
		'mcustcatId': mcustcatId};

}
