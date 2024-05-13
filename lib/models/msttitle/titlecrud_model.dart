class TitleCrudModel {
	String mtitleId;
	String titleDesc;

	TitleCrudModel({required this.mtitleId, required this.titleDesc});

	factory TitleCrudModel.fromJson(Map<String, dynamic> data) =>
		TitleCrudModel(
			mtitleId: data['mtitleId'],
			titleDesc: data['titleDesc']
		);

	Map<String, dynamic> toJson() =>
		{'mtitleId': mtitleId,
		'titleDesc': titleDesc};

}
