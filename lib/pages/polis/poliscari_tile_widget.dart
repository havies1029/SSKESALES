import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:esalesapp/widgets/my_colors.dart';
import 'package:esalesapp/widgets/my_text.dart';

class PolisCariTileWidget extends StatelessWidget {
  final double cstPremi;
  final String insuredNama;
  final DateTime periodeAkhir;
  final DateTime periodeAwal;
  final String polisNo;
  final String polis1Id;
  final double tsi;
  final String cobNama;
  final String rekanNama;

  const PolisCariTileWidget(
      {super.key,
      required this.cstPremi,
      required this.insuredNama,
      required this.periodeAkhir,
      required this.periodeAwal,
      required this.polisNo,
      required this.polis1Id,
      required this.tsi,
      required this.cobNama,
      required this.rekanNama});

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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Customer",
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_40)),
            Container(height: 5),
            Text(rekanNama,
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_80)),
            Container(height: 10),
            Text("cstPremi",
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_40)),
            Container(height: 5),
            Text(NumberFormat("#,###").format(cstPremi),
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_80)),
            Container(height: 10),
            Text("insuredNama",
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_40)),
            Container(height: 5),
            Text(insuredNama,
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_80)),
            Container(height: 10),
            Text("periodeAkhir",
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_40)),
            Container(height: 5),
            Text(DateFormat("dd/MM/yyyy").format(periodeAkhir),
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_80)),
            Container(height: 10),
            Text("periodeAwal",
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_40)),
            Container(height: 5),
            Text(DateFormat("dd/MM/yyyy").format(periodeAwal),
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_80)),
            Container(height: 10),
            Text("polisNo",
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_40)),
            Container(height: 5),
            Text(polisNo,
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_80)),
            Container(height: 10),
            Text("polis1Id",
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_40)),
            Container(height: 5),
            Text(polis1Id,
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_80)),
            Container(height: 10),
            Text("tsi",
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_40)),
            Container(height: 5),
            Text(NumberFormat("#,###").format(tsi),
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_80)),
            Container(height: 10),
            Text("cobNama",
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_40)),
            Container(height: 5),
            Text(cobNama,
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_80)),
            Container(height: 10),
          ]),
        ));
  }
}
