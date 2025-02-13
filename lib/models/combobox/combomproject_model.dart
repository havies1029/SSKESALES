import 'package:equatable/equatable.dart';

class ComboMProjectModel extends Equatable {
	final String mprojectId;
	final String projectNama;
	final String mrekanId;

	const ComboMProjectModel({this.mprojectId='', this.projectNama='', this.mrekanId=''});

	factory ComboMProjectModel.fromJson(Map<String, dynamic> data) =>
		ComboMProjectModel(
			mprojectId: data['mprojectId'],
			projectNama: data['projectNama'],
			mrekanId: data['mrekanId']
		);

	Map<String, dynamic> toJson() =>
		{'mprojectId': mprojectId,
		'projectNama': projectNama,
		'mrekanId': mrekanId};

	@override
	List<Object> get props => [mprojectId, projectNama, mrekanId];
}
