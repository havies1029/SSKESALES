import 'package:esalesapp/pages/jobreal/jobrealcrud_form.dart';
import 'package:esalesapp/widgets/mobiledesign_widget.dart';
import 'package:flutter/material.dart';

class JobRealCrudMainPage extends StatelessWidget {
  final String viewMode;
  final String recordId;
  final bool isBriefingHarianMode;
  final bool isSOAClientMode;
  final bool isProjectMode;

  const JobRealCrudMainPage(
      {super.key,
      required this.viewMode,
      required this.recordId,
      required this.isBriefingHarianMode,
      required this.isSOAClientMode, 
      required this.isProjectMode});

  @override
  Widget build(BuildContext context) {
    return MobileDesignWidget(
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                  '${viewMode == "tambah" ? "Tambah" : viewMode == "ubah" ? "Ubah" : "Lihat"} Task'),
            ),
            //backgroundColor: Colors.grey[200],
            body: JobRealCrudFormPage(
                viewMode: viewMode,
                recordId: recordId,
                isBriefingHarianMode: isBriefingHarianMode,
                isSOAClientMode: isSOAClientMode,
                isProjectMode: isProjectMode)));
  }
}
