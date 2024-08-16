import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:esalesapp/widgets/my_colors.dart';
import 'package:esalesapp/widgets/my_text.dart';

class JobRealCariTileWidget extends StatelessWidget {
  final String hasil;
  final String jobreal1Id;
  final String materi;
  final String picName;
  final DateTime realJam;
  final DateTime realTgl;
  final String catName;
  final String jobNama;
  final String mediaNama;
  final String customerNama;
  final bool isConfirmed;
  final String catGroupName;

  const JobRealCariTileWidget(
      {super.key,
      required this.hasil,
      required this.jobreal1Id,
      required this.materi,
      required this.picName,
      required this.realJam,
      required this.realTgl,
      required this.catName,
      required this.jobNama,
      required this.mediaNama,
      required this.customerNama,
      this.isConfirmed = false,
      required this.catGroupName,});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: isConfirmed?Colors.blueGrey[200]:Colors.orange[200],
        margin: const EdgeInsets.symmetric(horizontal: 10),
        elevation: 2,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Registration ID",
                          style: MyText.bodyLarge(context)!
                              .copyWith(color: MyColors.grey_60)),
                      Container(height: 5),
                      Text(jobreal1Id,
                          style: MyText.bodyLarge(context)!
                              .copyWith(color: MyColors.grey_95)),
                      Container(height: 10),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Date",
                          style: MyText.bodyLarge(context)!
                              .copyWith(color: MyColors.grey_60)),
                      Container(height: 5),
                      Text(
                          "${DateFormat('dd/MM/yyyy').format(realTgl)} ${DateFormat('HH:mm').format(realJam)}",
                          style: MyText.bodyLarge(context)!
                              .copyWith(color: MyColors.grey_95)),
                      Container(height: 10),
                    ],
                  ),
                ),
              ],
            ),
            Text("Customer",
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_60)),
            Container(height: 5),
            Text(customerNama,
            
                style: MyText.titleLarge(context)!
                    .copyWith(
                    color: Colors.transparent,
                    shadows: [
                      const Shadow(
                          color: Colors.black,
                          offset: Offset(0, -5))
                    ],
                    decoration: TextDecoration.underline, 
                    decorationColor: Colors.black,
                    decorationThickness: 2.0 ),
                maxLines: 2,),
            Container(height: 10),
            Text("Perihal",
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_60)),
            Container(height: 5),
            Text(materi,
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_95)),
            Container(height: 10),
            Text("Feedback",
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_60)),
            Container(height: 5),
            Text(hasil,
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_95)),
            Container(height: 10),
            Container(
              decoration: BoxDecoration(
                  color: Colors.green[600],
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5.0),
                child: Text(jobNama,
                    textAlign: TextAlign.left,                    
                    style: MyText.bodyLarge(context)!
                    .copyWith(color: Colors.yellow),
                    
                  ),
              ),
            ),
            //Container(height: 5),
          ]),
        ));
  }
}
