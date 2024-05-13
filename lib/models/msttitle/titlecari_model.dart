class TitleCariModel {
	String mtitleId;
	String titleDesc;

	TitleCariModel({required this.mtitleId, required this.titleDesc});

	factory TitleCariModel.fromJson(Map<String, dynamic> data) =>
		TitleCariModel(
			mtitleId: data['mtitleId'],
			titleDesc: data['titleDesc']
		);

	Map<String, dynamic> toJson() =>
		{'mtitleId': mtitleId,
		'titleDesc': titleDesc};

}
