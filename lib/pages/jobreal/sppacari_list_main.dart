import 'package:esalesapp/pages/jobreal/sppacari_list.dart';
import 'package:esalesapp/widgets/mobiledesign_widget.dart';
import 'package:flutter/material.dart';

class SppaCariListMainPage extends StatelessWidget {
  final String jobRealId;
  final String titlePage;
  final String custName;
  const SppaCariListMainPage({super.key, required this.jobRealId, required this.titlePage, required this.custName});

  @override
  Widget build(BuildContext context) {
    return MobileDesignWidget(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
                '$titlePage - $custName'),
          ),
          body: SppaCariPage(jobRealId: jobRealId)),
    );
  }
}
