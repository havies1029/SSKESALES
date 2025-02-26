import 'package:esalesapp/pages/projectplan/planlist_list_widget.dart';
import 'package:esalesapp/widgets/mobiledesign_widget.dart';
import 'package:flutter/material.dart';

class PlanListMainPage extends StatelessWidget {
  final String clientName;
  final String projectName;
  final String projectId;
  const PlanListMainPage(
      {super.key,
      required this.clientName,
      required this.projectName,
      required this.projectId});

  @override
  Widget build(BuildContext context) {
    return MobileDesignWidget(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text("Project : $projectName")
        ),
        body: PlanListListWidget(projectId: projectId),
      ),
    );
  }
}
