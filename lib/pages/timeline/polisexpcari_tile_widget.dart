import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:esalesapp/widgets/my_colors.dart';
import 'package:esalesapp/widgets/my_text.dart';

class PolisExpCariTileWidget extends StatelessWidget {
  final int severity;
  final String cobNama;
  final double cstPremi;
  final String curr;
  final String insuredNama;
  final DateTime periodeAkhir;
  final DateTime periodeAwal;
  final String polis1Id;
  final String sppaNo;
  final double tsi;
  final String newSppaNo;
  final String newSppaStatus;

  const PolisExpCariTileWidget(
      {super.key,
      required this.severity,
      required this.cobNama,
      required this.cstPremi,
      required this.curr,
      required this.insuredNama,
      required this.periodeAkhir,
      required this.periodeAwal,
      required this.polis1Id,
      required this.sppaNo,
      required this.tsi,
      required this.newSppaNo,
      required this.newSppaStatus});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: PolisExpColor.backgroundColor(severity),
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
                    style: MyText.bodyLarge(context)!
                    .copyWith(color: PolisExpColor.textColor(severity), fontWeight: FontWeight.w700)),
                const Spacer(),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(40)),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(" $cobNama ",
                          textAlign: TextAlign.right,
                          style: Theme.of(context).textTheme.titleSmall),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5,),
            Text(insuredNama,
                textAlign: TextAlign.left,
                maxLines: 1,
                style: MyText.titleLarge(context)!
                    .copyWith(color: PolisExpColor.textColor(severity))),            
            const SizedBox(height: 5,),
            Row(
              children: [
                Text(
                    '${DateFormat('dd/MM/yyyy').format(periodeAwal)} - ${DateFormat('dd/MM/yyyy').format(periodeAkhir)}',
                    textAlign: TextAlign.left,
                    style: MyText.bodyLarge(context)!
                    .copyWith(color: PolisExpColor.textColor(severity), fontWeight: FontWeight.w700))
              ],
            ),
            const SizedBox(height: 5,),
            const Divider(thickness: 3, color: Colors.blueGrey,),
            Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("TSI :",
                          style: MyText.bodyLarge(context)!
                      .copyWith(color: PolisExpColor.labelColor(severity))),
                      Container(height: 5),
                      Text('$curr ${NumberFormat("#,###").format(tsi)}',
                          style: MyText.bodyLarge(context)!
                      .copyWith(color: PolisExpColor.textColor(severity), fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Premi :",
                          style: MyText.bodyLarge(context)!
                      .copyWith(color: PolisExpColor.labelColor(severity))),
                      Container(height: 5),
                      Text("$curr ${NumberFormat("#,###").format(cstPremi)}",
                        textAlign: TextAlign.right,
                        style: MyText.bodyLarge(context)!
                        .copyWith(color: PolisExpColor.textColor(severity), fontWeight: FontWeight.w700))
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5,),
            const Divider(thickness: 3, color: Colors.blueGrey,),
            Text("New SPPA :",
                style: MyText.bodyLarge(context)!
            .copyWith(color: PolisExpColor.labelColor(severity))),
            Container(height: 5),
            Text(newSppaNo,
              textAlign: TextAlign.left,
              style: MyText.bodyLarge(context)!
                    .copyWith(color: PolisExpColor.textColor(severity))),            
            const SizedBox(height: 10,),
            Text("Last Action :",
                style: MyText.bodyLarge(context)!
            .copyWith(color: PolisExpColor.labelColor(severity))),
            Container(height: 5),
            Text(newSppaStatus,
              textAlign: TextAlign.left,
              style: MyText.bodyLarge(context)!
                    .copyWith(color: PolisExpColor.textColor(severity))),  
          ]),
        ));
  }
}
