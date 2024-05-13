import 'package:esalesapp/pages/jobreal/jobreal2cari_list.dart';
import 'package:esalesapp/widgets/mobiledesign_widget.dart';
import 'package:flutter/material.dart';

class JobReal2CariMainPage extends StatelessWidget {
  final String custId;
  final String jobCatId;
  final String jobReal1Id;
  final String custName;

  const JobReal2CariMainPage(
      {super.key,
      required this.custId,
      required this.jobCatId,
      required this.jobReal1Id,
      required this.custName});

  @override
  Widget build(BuildContext context) {
    return MobileDesignWidget(
        child: Scaffold(
            appBar: AppBar(
              title: Text('Daftar Polis $custName'),
            ),
            //backgroundColor: Colors.grey[200],
            body: JobReal2CariPage(
                custId: custId, jobCatId: jobCatId, jobReal1Id: jobReal1Id)));
  }
}
