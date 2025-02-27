import 'package:esalesapp/blocs/mstproject/projectlist_bloc.dart';
import 'package:esalesapp/pages/mstproject/projectlist_dialog_startproject.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocListener<ProjectListBloc, ProjectListState>(
      listenWhen: (context, state) {
        return state.hasFailure;
      },
      listener: (context, state) {
        if (state.hasFailure){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.errorMsg),
              backgroundColor: Colors.red,
            ));
        }
      },
      child: Card(
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
                      Text("Tap"),
                      TextButton(
                          onPressed: () {
                            if (isValidStatProject()) {
                              showDialogStartProject(widget.mprojectId);
                            }
                            else {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text("COB dan Job Category tidak boleh kosong."),
                                backgroundColor: Colors.red,
                              ));
                            }
                          },
                          child: Container(
                            width: 70,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(8)),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("here",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.yellow[400],
                                      fontStyle: FontStyle.italic)),
                            ),
                          )),
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
          )),
    );
  }

  void showDialogStartProject(String projectId) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return DialogStartProjectWidget(projectId: projectId);
        });
  }

  bool isValidStatProject() {
    bool isValid = true;

    if ((widget.cobNama.isEmpty) || (widget.catName.isEmpty)) {
      isValid = false;
    }

    return isValid;
  }
}
