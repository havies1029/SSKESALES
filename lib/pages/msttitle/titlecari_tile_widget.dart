import 'package:flutter/material.dart';
import 'package:esalesapp/widgets/my_colors.dart';
import 'package:esalesapp/widgets/my_text.dart';

class TitleCariTileWidget extends StatelessWidget {
	final String mtitleId;
	final String titleDesc;

	const TitleCariTileWidget(
		{super.key,
		required this.mtitleId, 
		required this.titleDesc});

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
						Text(
							titleDesc,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
							Container(height: 10),
				]),
			)
		);
	}
}
