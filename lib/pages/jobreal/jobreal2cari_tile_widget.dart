import 'package:flutter/material.dart';
import 'package:esalesapp/widgets/my_colors.dart';
import 'package:esalesapp/widgets/my_text.dart';
import 'package:intl/intl.dart';

class JobReal2CariTileWidget extends StatelessWidget {
  final String polis1Id;
	final String? polisNo;
	final String sppaNo;
	final DateTime periodeAwal;
	final DateTime? periodeAkhir;
	final String curr;
	final double cstPremi;
	final double tsi;
	final String cob;
	final String insuredNama;
	final String jobreal2Id;

	const JobReal2CariTileWidget(
		{super.key, required this.polis1Id, this.polisNo, 
    required this.periodeAwal, this.periodeAkhir, 
    required this.curr, required this.cstPremi, 
    required this.tsi, required this.cob, required this.insuredNama, 
    required this.jobreal2Id, required this.sppaNo});

	@override
	Widget build(BuildContext context) {
		return Container(
			alignment: Alignment.topLeft,
			padding: const EdgeInsets.all(15),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [						
		            Row(
		              mainAxisAlignment: MainAxisAlignment.start,
		              children: [
		                Flexible(
		                  flex: 1,
		                  child: Column(
		                    crossAxisAlignment: CrossAxisAlignment.start,
		                    children: [
		                      Text("SPPA No",
		                          style: MyText.bodyLarge(context)!
		                            .copyWith(color: MyColors.grey_40)),
		                      Container(height: 5),
		                      Text(
		                        sppaNo,
		                        style: MyText.bodyLarge(context)!
		                          .copyWith(color: MyColors.grey_80)),
		                    ],
		                  ),
		                ),
		                const SizedBox(width: 8.0,),
		                Flexible(
		                  flex: 1,
		                  child: Column(
		                    crossAxisAlignment: CrossAxisAlignment.start,
		                    children: [
		                      Text("Policy No",
		                        style: MyText.bodyLarge(context)!
		                          .copyWith(color: MyColors.grey_40)),
		                      Container(height: 5),
		                      Text(
		                        polisNo??"",
		                        style: MyText.bodyLarge(context)!
		                          .copyWith(color: MyColors.grey_80)),
		                      Container(height: 10),
		                    ],
		                  ),
		                ),
		              ],
		            ),						
					Container(height: 10),
		            Text("The Insured",
						style: MyText.bodyLarge(context)!
							.copyWith(color: MyColors.grey_40)),
					Container(height: 5),
					Text(
						insuredNama,
						style: MyText.bodyLarge(context)!
							.copyWith(color: MyColors.grey_80)),
					Container(height: 10),
		            Text("Period",
						style: MyText.bodyLarge(context)!
							.copyWith(color: MyColors.grey_40)),
					Container(height: 5),
					Text(
						"${DateFormat("dd-MM-yyyy").format(periodeAwal)} ${periodeAkhir != null?(" -  ${DateFormat("dd-MM-yyyy").format(periodeAkhir!)}"):""}",
						style: MyText.bodyLarge(context)!
							.copyWith(color: MyColors.grey_80)),
					Container(height: 10),
		
		            Row(
		              mainAxisAlignment: MainAxisAlignment.start,
		              children: [
		                Flexible(
		                  flex: 1,
		                  child: Column(
		                    crossAxisAlignment: CrossAxisAlignment.start,
		                    children: [
		                      Text("TSI",
		                          style: MyText.bodyLarge(context)!
		                            .copyWith(color: MyColors.grey_40)),
		                      Container(height: 5),
		                      Text(
		                        "$curr ${NumberFormat("#,###").format(tsi)}",
		                        style: MyText.bodyLarge(context)!
		                          .copyWith(color: MyColors.grey_80)),
		                    ],
		                  ),
		                ),
		                const SizedBox(width: 5.0,),
		                Flexible(
		                  flex: 1,
		                  child: Column(
		                    crossAxisAlignment: CrossAxisAlignment.start,
		                    children: [
		                      Text("Premium",
		                        style: MyText.bodyLarge(context)!
		                          .copyWith(color: MyColors.grey_40)),
		                      Container(height: 5),
		                      Text(
		                        "$curr ${NumberFormat("#,###").format(cstPremi)}",
		                        style: MyText.bodyLarge(context)!
		                          .copyWith(color: MyColors.grey_80)),
		                      Container(height: 10),
		                    ],
		                  ),
		                ),
		              ],
		            ),						
					Container(height: 10),           
		            
			]),
		);
	}
}
