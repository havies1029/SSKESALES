import 'package:equatable/equatable.dart';

class ComboTitleModel extends Equatable {
	final String mtitleId;
	final String titleDesc;

	const ComboTitleModel({this.mtitleId='', this.titleDesc=''});

	factory ComboTitleModel.fromJson(Map<String, dynamic> data) =>
		ComboTitleModel(
			mtitleId: data['mtitleId'],
			titleDesc: data['titleDesc']
		);

	Map<String, dynamic> toJson() =>
		{'mtitleId': mtitleId,
		'titleDesc': titleDesc};

	@override
	List<Object> get props => [mtitleId, titleDesc];
}
