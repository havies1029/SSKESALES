import 'package:equatable/equatable.dart';

class ComboTodoListModel extends Equatable {
	final String timeline1Id;
	final String aktivitas;
  final DateTime? jamMulai;
  final DateTime? jamAkhir;

	const ComboTodoListModel({this.timeline1Id='', this.aktivitas='', this.jamMulai, this.jamAkhir});

	factory ComboTodoListModel.fromJson(Map<String, dynamic> data) =>
		ComboTodoListModel(
			timeline1Id: data['timeline1Id'],
			aktivitas: data['aktivitas'],
			jamMulai: data['jamMulai'] != null ? DateTime.parse(data['jamMulai']) : null,
			jamAkhir: data['jamAkhir'] != null ? DateTime.parse(data['jamAkhir']) : null,
		);

	Map<String, dynamic> toJson() =>
		{'timeline1Id': timeline1Id,
		'aktivitas': aktivitas,
		'jamMulai': jamMulai?.toIso8601String(),
		'jamAkhir': jamAkhir?.toIso8601String(),
		};

	@override
	List<Object?> get props => [timeline1Id, aktivitas, jamMulai, jamAkhir];
}
