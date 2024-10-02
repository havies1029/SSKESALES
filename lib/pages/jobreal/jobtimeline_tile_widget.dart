import 'package:flutter/material.dart';
import 'package:esalesapp/widgets/my_colors.dart';
import 'package:esalesapp/widgets/my_text.dart';

class JobtimelineTileWidget extends StatelessWidget {
	final String feedback;
	final int jobIdx;
	final String jobName;
	final DateTime jobTgl;
	final String materi;
	final int totalJob;

	const JobtimelineTileWidget(
		{super.key,
		required this.feedback, 
		required this.jobIdx, 
		required this.jobName, 
		required this.jobTgl, 
		required this.materi, 
		required this.totalJob});

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
        color: Colors.green[200],
				alignment: Alignment.topLeft,
				padding: const EdgeInsets.all(15),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [

            Text("Task",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_60, fontWeight: FontWeight.bold)),
						Container(height: 5),
						Text(
							jobName,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),


            Text("Perihal",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_60, fontWeight: FontWeight.bold)),
						Container(height: 5),
            
						Text(
							materi,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
            
						Text("Feedback",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_60, fontWeight: FontWeight.bold)),
						Container(height: 5),
            
						Text(
							feedback,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
            
            
				]),
			)
		);
	}
}
