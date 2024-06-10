import 'package:flutter/material.dart';
import 'package:esalesapp/widgets/my_colors.dart';
import 'package:esalesapp/widgets/my_text.dart';

class JobReal3GridTileWidget extends StatelessWidget {
	final String cobNama;

	const JobReal3GridTileWidget(
		{super.key,
		required this.cobNama});

	@override
	Widget build(BuildContext context) {
		return Card(
			shape: RoundedRectangleBorder(
				borderRadius: BorderRadius.circular(15),
			),
			color: Colors.white38,
			//margin: const EdgeInsets.symmetric(horizontal: 2),
			elevation: 2,
			clipBehavior: Clip.antiAliasWithSaveLayer,
			child: Container(
				alignment: Alignment.topLeft,
				padding: const EdgeInsets.all(10),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [										
						Text(
							cobNama,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_100_)),
						//Container(height: 10),
				]),
			)
		);
	}
}
