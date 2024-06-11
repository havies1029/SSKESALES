import 'package:esalesapp/pages/jobreal/jobrealcari_main.dart';
import 'package:esalesapp/widgets/mobiledesign_widget.dart';
import 'package:flutter/material.dart';

class RealGroupCariRoutePage extends StatelessWidget {
  final String personId;
  final String personName;

  const RealGroupCariRoutePage(
      {super.key,
      required this.personId,
      required this.personName});

  @override
  Widget build(BuildContext context) {
    return MobileDesignWidget(
        child: Scaffold(
            appBar: AppBar(
              title: Text('Daftar Task $personName'),
            ),            
            
            body: JobRealCariMainPage(
                personId: personId, readOnly: true,)));
  }

  
}
