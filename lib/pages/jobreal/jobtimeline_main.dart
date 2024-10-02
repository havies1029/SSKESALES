import 'package:esalesapp/pages/jobreal/jobtimeline_list_widget.dart';
import 'package:esalesapp/widgets/mobiledesign_widget.dart';
import 'package:flutter/material.dart';

class JobTimelineMainPage extends StatelessWidget{
  final String jobRealId;
  final String sppaNo;
  final String polisId;
  const JobTimelineMainPage({super.key, required this.jobRealId, required this.sppaNo, required this.polisId});

  @override
  Widget build(BuildContext context) {
    return MobileDesignWidget(
      child: Scaffold(
          appBar: AppBar(
            title: Text(sppaNo),
          ),
          body: JobtimelineListWidget(jobRealId: jobRealId, polisId: polisId)),
    );
  }
}