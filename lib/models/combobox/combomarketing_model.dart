import 'package:equatable/equatable.dart';

class ComboMarketingModel extends Equatable {
	final String msalesId;
	final String salesNama;

	const ComboMarketingModel({this.msalesId='', this.salesNama=''});

	factory ComboMarketingModel.fromJson(Map<String, dynamic> data) =>
		ComboMarketingModel(
			msalesId: data['msalesId'],
			salesNama: data['salesNama']
		);

	Map<String, dynamic> toJson() =>
		{'msalesId': msalesId,
		'salesNama': salesNama};

	@override
	List<Object> get props => [msalesId, salesNama];
}
