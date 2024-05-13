import 'package:equatable/equatable.dart';

class ComboJobModel extends Equatable {
	final String mjobId;
	final String jobNama;

	const ComboJobModel({this.mjobId='', this.jobNama=''});

	factory ComboJobModel.fromJson(Map<String, dynamic> data) =>
		ComboJobModel(
			mjobId: data['mjobId'],
			jobNama: data['jobNama'],
		);

	Map<String, dynamic> toJson() =>
		{'mjobId': mjobId,
		'jobNama': jobNama,};

	@override
	List<Object> get props => [mjobId, jobNama];
}
