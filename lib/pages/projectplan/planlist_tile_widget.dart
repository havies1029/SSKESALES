import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:esalesapp/widgets/my_colors.dart';
import 'package:esalesapp/widgets/my_text.dart';

class PlanListTileWidget extends StatelessWidget {
	final String jobNama;
	final int planDurasi;
	final DateTime planFinish;
	final DateTime planStart;
	final String plan1Id;
	final int urutan;

	const PlanListTileWidget(
		{super.key,
		required this.jobNama, 
		required this.planDurasi, 
		required this.planFinish, 
		required this.planStart, 
		required this.plan1Id, 
		required this.urutan});

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
						Text("Task Name",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							jobNama,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
            
            Row(
              children: [
                Flexible(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Plan Start",
                        style: MyText.bodyLarge(context)!
                          .copyWith(color: MyColors.grey_40)),
                      Container(height: 5),
                      Text(
                        DateFormat("dd/MM/yyyy").format(planStart),
                        style: MyText.bodyLarge(context)!
                          .copyWith(color: MyColors.grey_80)),
                    ],
                  )),
                  Flexible(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Plan Duration",
                        style: MyText.bodyLarge(context)!
                          .copyWith(color: MyColors.grey_40)),
                      Container(height: 5),
                      Text(
                        "${NumberFormat("#,###").format(planDurasi)} day(s)",
                        style: MyText.bodyLarge(context)!
                          .copyWith(color: MyColors.grey_80)),
                    ],
                  ))
              ],
            ),						
						Container(height: 10),
						Text("Plan Finish",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							DateFormat("dd/MM/yyyy").format(planFinish),
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),						
				]),
			)
		);
	}
}
