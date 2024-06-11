
class JobSalesCariModel {
	String orgName;
	String personId;
	String personName;

	JobSalesCariModel({required this.orgName, required this.personId, 
		required this.personName});

	factory JobSalesCariModel.fromJson(Map<String, dynamic> data) {
		return JobSalesCariModel(
			orgName: data['orgName']??'',
			personId: data['personId']??'',
			personName: data['personName']??''
		);

	}

	Map<String, dynamic> toJson() =>
		{'orgName': orgName,
		'personId': personId,
		'personName': personName};

}
