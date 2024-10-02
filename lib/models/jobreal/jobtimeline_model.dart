
class JobtimelineModel {
	String feedback;
	int jobIdx;
	String jobName;
	DateTime jobTgl;
	String materi;
	int totalJob;
	String jobStatus;

	JobtimelineModel({required this.feedback, required this.jobIdx, 
		required this.jobName, required this.jobTgl, 
		required this.materi, required this.totalJob,
    required this.jobStatus});

	factory JobtimelineModel.fromJson(Map<String, dynamic> data) {
		return JobtimelineModel(
			feedback: data['feedback']??'',
			jobIdx: int.tryParse(data['jobIdx'].toString())??0,
			jobName: data['jobName']??'',
			jobTgl: DateTime.tryParse(data['jobTgl'].toString())??DateTime.now(),
			materi: data['materi']??'',
			totalJob: int.tryParse(data['totalJob'].toString())??0,      
			jobStatus: data['jobStatus']??'',
		);

	}

	Map<String, dynamic> toJson() =>
		{'feedback': feedback,
		'jobIdx': jobIdx.toString(),
		'jobName': jobName,
		'jobTgl': jobTgl.toIso8601String(),
		'materi': materi,
		'totalJob': totalJob.toString(),    
		'jobStatus': jobStatus};

}
