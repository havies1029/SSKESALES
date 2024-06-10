
class JobCatCariModel {
	String catName;
	String mjobcatId;
	String custCatName;

	JobCatCariModel({required this.catName, required this.mjobcatId,
    required this.custCatName});

	factory JobCatCariModel.fromJson(Map<String, dynamic> data) {
		return JobCatCariModel(
			catName: data['catName']??'',
			mjobcatId: data['mjobcatId']??'',
			custCatName: data['custCatName']??'',
		);

	}

	Map<String, dynamic> toJson() =>
		{'catName': catName,
		'mjobcatId': mjobcatId,
		'custCatName': custCatName,
    };

}
