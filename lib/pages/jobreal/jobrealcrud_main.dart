import 'package:esalesapp/pages/jobreal/jobrealcrud_form.dart';
import 'package:esalesapp/widgets/mobiledesign_widget.dart';
import 'package:flutter/material.dart';

class JobRealCrudMainPage extends StatelessWidget {
  final String viewMode;
  final String recordId;

  const JobRealCrudMainPage(
      {super.key, required this.viewMode, required this.recordId});

  @override
  Widget build(BuildContext context) {   

    return MobileDesignWidget(
        child: Scaffold(
            appBar: AppBar(
              title: Text('${viewMode == "tambah"?"Tambah":"Ubah"} Action'),
            ),
            //backgroundColor: Colors.grey[200],
            body: JobRealCrudFormPage(viewMode: viewMode, recordId: recordId)));
  }
}
