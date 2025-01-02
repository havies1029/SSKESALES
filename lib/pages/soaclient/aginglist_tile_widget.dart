import 'package:esalesapp/pages/soaclient/dnlist_main.dart';
import 'package:flutter/material.dart';
import 'package:esalesapp/widgets/my_colors.dart';
import 'package:esalesapp/widgets/my_text.dart';
import 'package:intl/intl.dart';

class AginglistTileWidget extends StatelessWidget {
  final String agingDesc;
  final String msoaagingId;
  final int range1;
  final int range2;
  final int dnCount;
  final double osAmount;
  final int severity;

  const AginglistTileWidget(
      {super.key,
      required this.agingDesc,
      required this.msoaagingId,
      required this.range1,
      required this.range2,
      required this.dnCount,
      required this.osAmount,      
      required this.severity});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        //color: Colors.white,
        color: SoaAgingColor.backgroundColor(severity),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        elevation: 2,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return DNListMainPage(
                  soaAgingId: msoaagingId,
                  titlePage: agingDesc,
                );
              }),
            );
          },
          child: Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(15),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('${NumberFormat("#,###").format(dnCount)} dn(s)',
                  style: MyText.titleMedium(context)!.copyWith(
                      color: MyColors.grey_90, fontWeight: FontWeight.bold)),
              Text('IDR ${NumberFormat("#,###").format(osAmount)},-',
                  style: MyText.bodyMedium(context)!.copyWith(
                      color: MyColors.grey_90, fontWeight: FontWeight.normal)),
            ]),
          ),
        ));
  }
}
