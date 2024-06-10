
class JobCariModel {
	String jobNama;
	String mjobId;
	String catName;  
	String custCatName;

	JobCariModel({required this.jobNama, required this.mjobId, 
		required this.catName, required this.custCatName});

	factory JobCariModel.fromJson(Map<String, dynamic> data) {
		return JobCariModel(
			jobNama: data['jobNama']??'',
			mjobId: data['mjobId']??'',
			catName: data['catName']??'',
			custCatName: data['custCatName']??''
		);

	}

	Map<String, dynamic> toJson() =>
		{'jobNama': jobNama,
		'mjobId': mjobId,
		'catName': catName,
		'custCatName': custCatName};

}
