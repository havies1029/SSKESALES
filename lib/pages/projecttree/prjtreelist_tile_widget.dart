import 'package:esalesapp/pages/projecttree/prjtreelist_dialog.dart';
import 'package:flutter/material.dart';
import 'package:esalesapp/widgets/my_colors.dart';
import 'package:esalesapp/widgets/my_text.dart';
import 'package:intl/intl.dart';

class PrjtreeListTileWidget extends StatefulWidget {
	final String prjtree1Id;
	final String projectNama;
  final DateTime? startedDate;

	const PrjtreeListTileWidget(
		{super.key,
		required this.prjtree1Id, 
		required this.projectNama,
    this.startedDate});

  @override
  PrjtreeListTileWidgetState createState() => PrjtreeListTileWidgetState();
}

class PrjtreeListTileWidgetState extends State<PrjtreeListTileWidget> {	

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
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
						Text("Project ID",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							widget.prjtree1Id,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
						Text("Project Name",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							widget.projectNama,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
            widget.startedDate == null
                  ? Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Text("Tap"),
                      TextButton(
                          onPressed: () {                            
                            showDialogStartProject(widget.prjtree1Id);                            
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
            ]
				),
			)
		);
	}

  void showDialogStartProject(String projectId) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return PrjTreeDialogWidget(projectId: projectId);
        });
  } 

}
