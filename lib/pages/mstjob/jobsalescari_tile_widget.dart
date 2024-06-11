import 'package:esalesapp/pages/mstjob/jobsalescari_detail.dart';
import 'package:flutter/material.dart';
import 'package:esalesapp/widgets/my_colors.dart';
import 'package:esalesapp/widgets/my_text.dart';

class JobSalesCariTileWidget extends StatelessWidget {
	final String orgName;
	final String personId;
	final String personName;

	const JobSalesCariTileWidget(
		{super.key,
		required this.orgName, 
		required this.personId, 
		required this.personName});

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
				  children: [
				    Expanded(
              flex: 10,
              child: Text(
                personName,
                style: MyText.bodyLarge(context)!
                  .copyWith(color: MyColors.grey_80)),
            ),        
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return JobsalescariDetailPage(personId: personId, personName: personName);
                    }),
                  );
                },
                child: const Icon(
                  Icons.arrow_forward_ios,
                  size: 25.0,
                ),
              ),
            )
				  ],
				),
			)
		);
	}
}
