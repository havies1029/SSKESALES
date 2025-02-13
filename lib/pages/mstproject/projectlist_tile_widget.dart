import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:esalesapp/widgets/my_colors.dart';
import 'package:esalesapp/widgets/my_text.dart';

class ProjectListTileWidget extends StatelessWidget {
  final DateTime dateline;
  final String mprojectId;
  final String projectNama;
  final String clientName;

  const ProjectListTileWidget(
      {super.key,
      required this.dateline,
      required this.mprojectId,
      required this.projectNama,
      required this.clientName});

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
            Column(crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
              Text("Client Name",
                  style: MyText.bodyLarge(context)!
                      .copyWith(color: MyColors.grey_40)),
              Container(height: 5),
              Text(clientName,
                  style: MyText.bodyLarge(context)!
                      .copyWith(color: MyColors.grey_80)),
              Container(height: 10),
              Text("Project Name",
                  style: MyText.bodyLarge(context)!
                      .copyWith(color: MyColors.grey_40)),
              Container(height: 5),
              Text(projectNama,
                  style: MyText.bodyLarge(context)!
                      .copyWith(color: MyColors.grey_80)),
              Container(height: 10),
              Text("Dateline",
                  style: MyText.bodyLarge(context)!
                      .copyWith(color: MyColors.grey_40)),
              Container(height: 5),
              Text(DateFormat("dd/MM/yyyy").format(dateline),
                  style: MyText.bodyLarge(context)!
                      .copyWith(color: MyColors.grey_80)),
              Container(height: 10),
          ]),
        ));
  }
}
