import 'dart:typed_data';

import 'package:esalesapp/apis/jobreal/jobrealfoto_api.dart';
import 'package:esalesapp/models/image/downloadfileinfo64.dart';
import 'package:esalesapp/models/responseAPI/returndataapi_model.dart';

class JobRealFotoRepository {
  JobRealFotoAPI api = JobRealFotoAPI();

  Future<void> uploadFotoJobReal(String jobReal1Id, String filePath) async {
    await api.uploadFotoJobReal(jobReal1Id, filePath);
  }

  Future<ReturnDataAPI> uploadFotoBytesJobReal(String jobReal1Id, String fileName, Uint8List bytes) async {
    return await api.uploadFotoBytesJobReal(jobReal1Id, fileName, bytes);
  }

  Future<DownloadFileInfo64Model?> downloadFotoJobReal(String jobReal1Id) async {
    return await api.downloadFotoJobRealAPI(jobReal1Id);
  }

	Future<bool> jobRealCrudHapusFoto(String jobreal1Id) async {
		return await api.jobRealCrudHapusFotoAPI(jobreal1Id);
	}
}
