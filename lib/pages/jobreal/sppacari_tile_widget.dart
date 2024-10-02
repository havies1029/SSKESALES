import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:esalesapp/widgets/my_colors.dart';
import 'package:esalesapp/widgets/my_text.dart';

class SppaCariTileWidget extends StatelessWidget {
	final DateTime periodeAkhir;
	final DateTime periodeAwal;
	final String sppaNo;
  final String lastTask;
  final int jobIndex;
  final int totalJob;
  final int jobCount;
  final String cob;

	const SppaCariTileWidget(
		{super.key,
		required this.periodeAkhir, required this.periodeAwal, 
    required this.sppaNo, required this.lastTask, 
    required this.jobIndex, required this.totalJob, 
    required this.jobCount, required this.cob});

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
            Row(              
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: Column(                    
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("SPPA #",
                        style: MyText.bodyLarge(context)!
                          .copyWith(color: MyColors.grey_60, fontWeight: FontWeight.bold)),
                      Container(height: 5),
                      Text(
                        sppaNo,
                        style: MyText.bodyLarge(context)!
                          .copyWith(color: MyColors.grey_80)),
                    ],
                )),
                Flexible(
                  flex: 1,
                  child: Column(
                    children: [
                      Text("COB",
                        style: MyText.bodyLarge(context)!
                          .copyWith(color: MyColors.grey_60, fontWeight: FontWeight.bold)),
                      Container(height: 5),
                      Text(
                        cob,
                        style: MyText.bodyLarge(context)!
                          .copyWith(color: MyColors.grey_80)),
                    ],
                ))
              ],
            ),
						Container(height: 10),
						Text("Period",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_60, fontWeight: FontWeight.bold)),
						Container(height: 5),
						Text('${DateFormat("dd/MM/yyyy").format(periodeAwal)} - ${DateFormat("dd/MM/yyyy").format(periodeAkhir)}',
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),						
            Text("Last Task",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_60, fontWeight: FontWeight.bold)),
						Container(height: 5),
						Text(
							lastTask,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 5),
            const Divider(thickness: 2, color: Colors.black,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: Container(                    
                    color: Colors.blue[200],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                          child: Text("Task Count",
                              style: MyText.bodyLarge(context)!
                                  .copyWith(color: MyColors.grey_80, fontWeight: FontWeight.w900)),
                        ),                        
                        const Divider(thickness: 2, color: Colors.black,),
                        Text('$jobCount',
                            style: MyText.bodyLarge(context)!
                                .copyWith(color: MyColors.grey_95)),
                        Container(height: 10),
                      ],
                    
                    ),
                  )
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    color: Colors.amber[200],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                          child: Text("Last Index",
                              style: MyText.bodyLarge(context)!
                                  .copyWith(color: MyColors.grey_80, fontWeight: FontWeight.w900)),
                        ),
                        const Divider(thickness: 2, color: Colors.black,),
                        Text('$jobIndex',
                            style: MyText.bodyLarge(context)!
                                .copyWith(color: MyColors.grey_95)),
                        Container(height: 10),
                      ],
                    ),
                  )
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    color: Colors.deepOrangeAccent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                          child: Text("Total Task",
                              style: MyText.bodyLarge(context)!
                                  .copyWith(color: MyColors.grey_80, fontWeight: FontWeight.w900)),
                        ),
                        const Divider(thickness: 2, color: Colors.black,),
                        Text('$totalJob',
                            style: MyText.bodyLarge(context)!
                                .copyWith(color: MyColors.grey_95)),
                        Container(height: 10),
                      ],
                    ),
                  )
                )

              ],
            )	
				]),
			)
		);
	}
}
