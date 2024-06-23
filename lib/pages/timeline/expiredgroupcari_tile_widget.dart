import 'package:esalesapp/common/app_data.dart';
import 'package:esalesapp/pages/timeline/expiredbysales_main.dart';
import 'package:esalesapp/pages/timeline/polisexpcari_main.dart';
import 'package:flutter/material.dart';
import 'package:esalesapp/widgets/my_colors.dart';
import 'package:esalesapp/widgets/my_text.dart';
import 'package:intl/intl.dart';

class ExpiredGroupCariTileWidget extends StatelessWidget {
  final String expgroupId;
  final String groupNama;
  final int jml;
  final int noUrut;

  const ExpiredGroupCariTileWidget(
      {super.key,
      required this.expgroupId,
      required this.groupNama,
      required this.jml,
      required this.noUrut});

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
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return AppData.hasDownline ? ExpiredBySalesMainPage(
                  severity: noUrut,
                  expgroupId: expgroupId,
                  groupName: groupNama,
                ): PolisExpCariMainPage(
                  expgroupId: expgroupId, 
                  groupName: groupNama, 
                  severity: noUrut, 
                  personalId: AppData.personId, 
                  personalNama: AppData.personName);
              }),
            );
          },
          child: Container(
            color: PolisExpColor.backgroundColor(noUrut),
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(15),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(groupNama,
                  style: MyText.bodyLarge(context)!.copyWith(
                      color: PolisExpColor.textColor(noUrut),
                      fontWeight: FontWeight.bold)),
              Container(height: 5),
              const Divider(thickness: 2, color: Colors.blueGrey,),
              Text('${NumberFormat("#,###").format(jml)} policies',
                  style: MyText.bodyLarge(context)!.copyWith(
                      color: PolisExpColor.textColor(noUrut),
                      fontWeight: FontWeight.bold)),
              Container(height: 5),
            ]),
          ),
        ));
  }
}
