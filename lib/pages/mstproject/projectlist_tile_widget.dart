import 'package:esalesapp/pages/mstproject/projectlist_dialog_startproject.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:esalesapp/widgets/my_colors.dart';
import 'package:esalesapp/widgets/my_text.dart';

class ProjectListTileWidget extends StatefulWidget {
  final DateTime dateline;
  final String mprojectId;
  final String projectNama;
  final String clientName;
  final String cobNama;
  final String catName;
  final DateTime? startedDate;

  const ProjectListTileWidget(
      {super.key,
      required this.dateline,
      required this.mprojectId,
      required this.projectNama,
      required this.clientName,
      required this.cobNama,
      required this.catName,
      this.startedDate});

  @override
  ProjectListTileWidgetState createState() => ProjectListTileWidgetState();
}

class ProjectListTileWidgetState extends State<ProjectListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        elevation: 2,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Client Name",
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_40)),
            Container(height: 5),
            Text(widget.clientName,
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_80)),
            Container(height: 10),
            Text("COB",
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_40)),
            Container(height: 5),
            Text(widget.cobNama,
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_80)),
            Container(height: 10),
            Text("Job Category",
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_40)),
            Container(height: 5),
            Text(widget.catName,
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_80)),
            Container(height: 10),
            Text("Project Name",
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_40)),
            Container(height: 5),
            Text(widget.projectNama,
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_80)),
            Container(height: 10),
            Text("Dateline",
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_40)),
            Container(height: 5),
            Text(DateFormat("dd/MM/yyyy").format(widget.dateline),
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_80)),
            Container(height: 10),
            widget.startedDate == null
                ? Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Text("Click"),
                    TextButton(
                        onPressed: () {
                          showDialogStartProject(widget.mprojectId);
                        },
                        child: Text("here",
                            style: TextStyle(fontStyle: FontStyle.italic))),
                    Text("to start this project !"),
                  ])
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Started",
                          style: MyText.bodyLarge(context)!
                              .copyWith(color: MyColors.grey_40)),
                      Container(height: 5),
                      Text(
                          widget.startedDate != null
                              ? DateFormat("dd/MM/yyyy")
                                  .format(widget.startedDate!)
                              : '-',
                          style: MyText.bodyLarge(context)!
                              .copyWith(color: MyColors.grey_80)),
                    ],
                  ),
            Container(height: 10),
          ]),
        ));
  }

  void showDialogStartProject(String projectId) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return DialogStartProjectWidget(projectId: projectId);
        });
  }
}
