import 'package:esalesapp/pages/jobreal/jobtimeline_list_widget.dart';
import 'package:esalesapp/widgets/mobiledesign_widget.dart';
import 'package:flutter/material.dart';

class JobTimelineNonSppaMainPage extends StatelessWidget{
  final String jobRealId;
  final String titlePage;
  final String custName;
  const JobTimelineNonSppaMainPage({super.key, required this.jobRealId, required this.titlePage, required this.custName});

  @override
  Widget build(BuildContext context) {
    return MobileDesignWidget(
      child: Scaffold(
          appBar: AppBar(
            title: Text("$titlePage - $custName"),
          ),
          body: JobtimelineListWidget(jobRealId: jobRealId, polisId: "")),
    );
  }
}