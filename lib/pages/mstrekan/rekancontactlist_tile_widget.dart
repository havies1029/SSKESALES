import 'package:flutter/material.dart';
import 'package:esalesapp/widgets/my_colors.dart';
import 'package:esalesapp/widgets/my_text.dart';

class RekanContactListTileWidget extends StatelessWidget {
	final String contactNama;
	final String email;
	final String noHp;
	final String titleDesc;
  final String jabatanDesc;

	const RekanContactListTileWidget(
		{super.key,
		required this.contactNama, 
		required this.email, 
		required this.noHp, 
		required this.titleDesc, 
    required this.jabatanDesc});

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
							titleDesc + (titleDesc.isNotEmpty?" ": "") + contactNama,
							style: MyText.titleMedium(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
            Text(
							"Jabatan : $jabatanDesc",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 5),
            Text(
							"HP : $noHp",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 5),
						Text(
							"Email : $email",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 5),	
				]),
			)
		);
	}
}
