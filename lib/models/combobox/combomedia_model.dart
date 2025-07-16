import 'package:equatable/equatable.dart';

class ComboMediaModel extends Equatable {
  final String mmediaId;
  final String mediaNama;
  final bool needMoM;

  const ComboMediaModel({this.mmediaId = '', this.mediaNama = '', this.needMoM = false});

  factory ComboMediaModel.fromJson(Map<String, dynamic> data) =>
      ComboMediaModel(mmediaId: data['mmediaId'], mediaNama: data['mediaNama'], needMoM: data['needMoM']);

  Map<String, dynamic> toJson() =>
      {'mmediaId': mmediaId, 'mediaNama': mediaNama, 'needMoM': needMoM};

  @override
  List<Object> get props => [mmediaId, mediaNama, needMoM];
}
