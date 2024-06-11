import 'package:esalesapp/common/app_data.dart';
import 'package:flutter/material.dart';
import 'package:esalesapp/pages/jobreal/jobrealcari_list.dart';

class JobRealCariMainPage extends StatelessWidget {
  final bool readOnly;
  final String personId;
  const JobRealCariMainPage({super.key, required this.personId, required this.readOnly});

  @override
  Widget build(BuildContext context) {
    debugPrint("JobRealCariMainPage -> AppData.personId : ${AppData.personId}");
    debugPrint("JobRealCariMainPage -> personId : $personId");
    return Scaffold(
      //backgroundColor: Colors.grey[200],
      body: JobRealCariPage(personId: personId, readOnly: readOnly,),
    );
  }
}
