import 'package:esalesapp/pages/mstjob/jobcari_main.dart';
import 'package:esalesapp/widgets/mobiledesign_widget.dart';
import 'package:flutter/material.dart';

class JobsalescariDetailPage extends StatelessWidget {
  final String personId;
  final String personName;

  const JobsalescariDetailPage(
      {super.key,
      required this.personId,
      required this.personName});

  @override
  Widget build(BuildContext context) {
    return MobileDesignWidget(
        child: Scaffold(
            appBar: AppBar(
              title: Text('Daftar Task $personName'),
            ),            
            
            body: JobCariMainPage(
                personId: personId, personName: personName)));
  }

  
}
