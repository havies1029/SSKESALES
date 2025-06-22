
class TodoCompanyListModel {
	String customerName;
	String timeline2Id;

	TodoCompanyListModel({required this.customerName, 
		required this.timeline2Id});

	factory TodoCompanyListModel.fromJson(Map<String, dynamic> data) {
		return TodoCompanyListModel(
			customerName: data['customerName']??'',
			timeline2Id: data['timeline2Id']??''
		);

	}

	Map<String, dynamic> toJson() =>
		{'customerName': customerName,
		'timeline2Id': timeline2Id};

}
