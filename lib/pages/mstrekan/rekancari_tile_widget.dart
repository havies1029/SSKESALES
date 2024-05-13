import 'package:flutter/material.dart';
import 'package:esalesapp/widgets/my_colors.dart';
import 'package:esalesapp/widgets/my_text.dart';

class RekanCariTileWidget extends StatelessWidget {
	final String alamat1;
	final String alamat2;
	final String mrekanId;
	final String mtiperekanId;
	final String mtitleId;
	final String rekanNama;
	final String telp1;
	final String telp2;
	final String titleDesc;
	final String catName;

	const RekanCariTileWidget(
		{super.key,
		required this.alamat1, 
		required this.alamat2, 
		required this.mrekanId, 
		required this.mtiperekanId, 
		required this.mtitleId, 
		required this.rekanNama, 
		required this.telp1, 
		required this.telp2, 
		required this.titleDesc, 
		required this.catName});

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
            Text("Title",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							titleDesc,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
            Text("Nama Lengkap",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							rekanNama,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),            
						Text("Cateogry",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							catName,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),					
						Container(height: 10),
            Text("Alamat",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							alamat1,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),					
						Container(height: 5),
						Text(
							alamat2,              
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
						Text("Telp / HP",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
							Container(height: 5),
						Text(
							telp1,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),							
						Container(height: 5),
						Text(
							telp2,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
						
				]),
			)
		);
	}
}
