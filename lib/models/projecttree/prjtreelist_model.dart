
class PrjtreeListModel {
	String mmstjobcatId;
	String mrekanId;
	String prjtree1Id;
	String projectNama;
  DateTime? startedDate;

	PrjtreeListModel({required this.mmstjobcatId, required this.mrekanId, 
		required this.prjtree1Id, required this.projectNama,
    this.startedDate});

	factory PrjtreeListModel.fromJson(Map<String, dynamic> data) {

    DateTime? startedDate = data['startedDate'] != null
      ? DateTime.parse(data['startedDate'])
      : null;

		return PrjtreeListModel(
			mmstjobcatId: data['mmstjobcatId']??'',
			mrekanId: data['mrekanId']??'',
			prjtree1Id: data['prjtree1Id']??'',
			projectNama: data['projectNama']??'',
      startedDate: startedDate
		);

	}

	Map<String, dynamic> toJson() =>
		{'mmstjobcatId': mmstjobcatId,
		'mrekanId': mrekanId,
		'prjtree1Id': prjtree1Id,
		'projectNama': projectNama,
    'startedDate': startedDate?.toIso8601String()};

}
