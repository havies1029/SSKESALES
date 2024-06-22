import 'package:esalesapp/pages/timeline/polisexpcari_main.dart';
import 'package:flutter/material.dart';
import 'package:esalesapp/widgets/my_colors.dart';
import 'package:esalesapp/widgets/my_text.dart';
import 'package:intl/intl.dart';

class ExpiredBySalesTileWidget extends StatelessWidget {
  final int severity;
  final int jml;
  final String salesId;
  final String salesNama;
  final String expgroupId;
  final String groupName;

  const ExpiredBySalesTileWidget(
      {super.key,
      required this.severity,
      required this.jml,
      required this.salesId,
      required this.salesNama,
      required this.expgroupId,
      required this.groupName});

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
              Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  Text(salesNama,
                        style: MyText.bodyLarge(context)!
                            .copyWith(color: PolisExpColor.textColor(severity),
                            fontWeight: FontWeight.bold)),
                                  Container(height: 5),
                                  Text('${NumberFormat("#,###").format(jml)} policies',
                        style: MyText.titleLarge(context)!
                            .copyWith(color: PolisExpColor.textColor(severity),
                            fontWeight: FontWeight.bold)),
                                ]),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: IconButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return PolisExpCariMainPage(
                              severity: severity,
                              expgroupId: expgroupId,
                              groupName: groupName,
                              personalNama: salesNama,
                              personalId: salesId,
                            );
                          }),
                        );
                      }, 
                      icon: const Icon(
                        Icons.keyboard_double_arrow_right_rounded,
                          size: 35.0,)),
                  )
                ],
              ),
        ));
  }
}
