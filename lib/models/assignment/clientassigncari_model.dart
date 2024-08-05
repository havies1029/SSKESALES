
class ClientAssignCariModel {
	String clientId;
	String clientNama;
	String marketingId;

	ClientAssignCariModel({required this.clientId, required this.clientNama, 
		required this.marketingId});

	factory ClientAssignCariModel.fromJson(Map<String, dynamic> data) {
		return ClientAssignCariModel(
			clientId: data['clientId']??'',
			clientNama: data['clientNama']??'',
			marketingId: data['marketingId']??''
		);

	}

	Map<String, dynamic> toJson() =>
		{'clientId': clientId,
		'clientNama': clientNama,
		'marketingId': marketingId};

}
