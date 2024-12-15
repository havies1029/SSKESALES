import 'package:flutter/material.dart';
import 'package:esalesapp/widgets/my_colors.dart';
import 'package:esalesapp/widgets/my_text.dart';
import 'package:intl/intl.dart';

class BriefinglistTileWidget extends StatelessWidget {
	final bool inputed;
	final String jobId;
	final String jobNama;
	final int urutan;

	const BriefinglistTileWidget(
		{super.key,
		required this.inputed, 
		required this.jobId, 
		required this.jobNama, 
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
				child: Row(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
						Text(
							jobNama,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),            

				]),
			)
		);
	}
}
