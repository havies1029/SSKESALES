import 'package:esalesapp/apis/soaclient/tasksoainit_api.dart';
import 'package:esalesapp/models/soaclient/tasksoainit_model.dart';

class TasksoainitRepository {

	Future<TasksoainitModel> getTasksoainit(String dn1Id) async {

		TasksoainitAPI api = TasksoainitAPI();
		return await api.getTasksoainitAPI(dn1Id);
    
	}
}
