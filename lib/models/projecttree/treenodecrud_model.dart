
class TreenodeCrudModel {
	String prjnodetypeId;
	String prjtree1Id;
	String prjtree2Id;
	String prjtree2ParentId;
	String remarks1;
	String remarks2;

	TreenodeCrudModel({required this.prjnodetypeId, required this.prjtree1Id, 
		required this.prjtree2Id, required this.prjtree2ParentId, 
		required this.remarks1, required this.remarks2});

	factory TreenodeCrudModel.fromJson(Map<String, dynamic> data) {
		return TreenodeCrudModel(
			prjnodetypeId: data['prjnodetypeId']??'',
			prjtree1Id: data['prjtree1Id']??'',
			prjtree2Id: data['prjtree2Id']??'',
			prjtree2ParentId: data['prjtree2ParentId']??'',
			remarks1: data['remarks1']??'',
			remarks2: data['remarks2']??'',
		);

	}

	Map<String, dynamic> toJson() =>
		{'prjnodetypeId': prjnodetypeId,
		'prjtree1Id': prjtree1Id,
		'prjtree2Id': prjtree2Id,
		'prjtree2ParentId': prjtree2ParentId,
		'remarks1': remarks1,
		'remarks2': remarks2,};

}
