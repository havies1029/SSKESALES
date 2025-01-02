import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:esalesapp/widgets/my_colors.dart';
import 'package:esalesapp/widgets/my_text.dart';

class DnlistTileWidget extends StatelessWidget {
  final double dnAmount;
  final double dnBayar;
  final DateTime dnTgl;
  final String dn1Id;
  final DateTime extDate;
  final DateTime jthTempo;
  final String curr;
  final String sppaNo;
  final String insuredName;
  final String cobName;
  final int severity;
  final int aging;  

  const DnlistTileWidget(
      {super.key,
      required this.dnAmount,
      required this.dnBayar,
      required this.dnTgl,
      required this.dn1Id,
      required this.extDate,
      required this.jthTempo,
      required this.curr,
      required this.sppaNo,
      required this.insuredName,
      required this.cobName,
      required this.severity, 
      required this.aging,});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),        
        color: SoaAgingColor.backgroundColor(severity),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        elevation: 2,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(                    
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Text(sppaNo,
                    textAlign: TextAlign.left,
                    style: MyText.bodyLarge(context)!.copyWith(
                        color: SoaAgingColor.textColor(severity),
                        fontWeight: FontWeight.w700)),
                const Spacer(),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(40)),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(" $cobName ",
                          textAlign: TextAlign.right,
                          style: Theme.of(context).textTheme.titleSmall),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("DN #:",
                    style: MyText.bodyLarge(context)!
                        .copyWith(color: SoaAgingColor.labelColor(severity))),
                Container(height: 5),
                Text(dn1Id,
                    style: MyText.bodyLarge(context)!.copyWith(
                        color: SoaAgingColor.textColor(severity),
                        fontWeight: FontWeight.w700)),
              ],
            ),
            Text(insuredName,
                textAlign: TextAlign.left,
                maxLines: 1,
                style: MyText.titleLarge(context)!
                    .copyWith(color: SoaAgingColor.textColor(severity))),
            const SizedBox(
              height: 5,
            ),
            const Divider(
              thickness: 3,
              color: Colors.blueGrey,
            ),
            Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("PPW Date :",
                          style: MyText.bodyLarge(context)!.copyWith(
                              color: SoaAgingColor.labelColor(severity))),
                      Container(height: 5),
                      Text(DateFormat('dd/MM/yyyy').format(dnTgl),
                          style: MyText.bodyLarge(context)!.copyWith(
                              color: SoaAgingColor.textColor(severity),
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Extended PPW :",
                          style: MyText.bodyLarge(context)!.copyWith(
                              color: SoaAgingColor.labelColor(severity))),
                      Container(height: 5),
                      Text(DateFormat('dd/MM/yyyy').format(extDate),
                          textAlign: TextAlign.right,
                          style: MyText.bodyLarge(context)!.copyWith(
                              color: SoaAgingColor.textColor(severity),
                              fontWeight: FontWeight.w700))
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Outstanding :",
                          style: MyText.bodyLarge(context)!.copyWith(
                              color: SoaAgingColor.labelColor(severity))),
                      Container(height: 5),
                      Text(
                          '$curr ${NumberFormat("#,###").format((dnAmount - dnBayar))}',
                          style: MyText.bodyLarge(context)!.copyWith(
                              color: SoaAgingColor.textColor(severity),
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Aging :",
                          style: MyText.bodyLarge(context)!.copyWith(
                              color: SoaAgingColor.labelColor(severity))),
                      Container(height: 5),
                      Text("${NumberFormat("#,###").format(aging)} day(s)",
                          textAlign: TextAlign.right,
                          style: MyText.bodyLarge(context)!.copyWith(
                              color: SoaAgingColor.textColor(severity),
                              fontWeight: FontWeight.w700))
                    ],
                  ),
                ),
              ],
            ),
            
          ]),
        ));
  }
}
